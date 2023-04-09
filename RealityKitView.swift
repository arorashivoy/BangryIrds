//
//  RealityKitView.swift
//  SwiftStudent
//
//  Created by Shivoy Arora on 10/04/23.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity


/// View for RealityKit
struct RealityKitView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let view = ARView()
        
        // Start AR session
        let session = view.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
        
        // Add coaching overlay
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        view.addSubview(coachingOverlay)
        
        // Set debug options
#if DEBUG
        view.debugOptions = [.showFeaturePoints, .showAnchorOrigins, .showAnchorGeometry, .showPhysics]
#endif
        
        // Handle ARSession events via delegate
        context.coordinator.view = view
        session.delegate = context.coordinator
        
        // Handle taps
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap)
            )
        )
        
        return view
    }
    
    func updateUIView(_ view: ARView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        var focusEntity: FocusEntity?
        var anchor: AnchorEntity?
        var stageCreated: Bool = false
        let materialBlock: SimpleMaterial
        let materialSphere: SimpleMaterial
        let blockVerticle: MeshResource
        let blockHorizontal: MeshResource
        let ball: MeshResource
        
        override init() {
            // Creating the resources for making blocks and ball
            self.materialBlock = SimpleMaterial()
            self.materialSphere = SimpleMaterial(color: .gray, isMetallic: true)
            self.blockVerticle = MeshResource.generateBox(width: 0.2, height: 0.6, depth: 0.2, cornerRadius: 0.01)
            self.blockHorizontal = MeshResource.generateBox(width: 0.6, height: 0.2, depth: 0.2, cornerRadius: 0.01)
            self.ball = MeshResource.generateSphere(radius: 0.15)
        }
        
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
            debugPrint("Anchors added to the scene: ", anchors)
            self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
            
            // Create a new anchor to add content to
            self.anchor = AnchorEntity()
        }
        
        @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
            guard let view = self.view, let focusEntity = self.focusEntity, let anchor: AnchorEntity = self.anchor else { return }
            view.scene.anchors.append(anchor)
            
            // Finding the location of tap
            let tapLocation = recognizer.location(in: view)
            
            print("\n\n\n")
            print(tapLocation)
            print("\n\n\n")
            
            if !stageCreated {
                createStage(focusEntity: focusEntity, anchor: anchor)
                stageCreated = true
                return
            }
            
            
            // Checking if any entity is clicked
            if let entity = view.entity(at: tapLocation) as? ModelEntity{
                    sendBall(anchor: anchor, entity: entity)
            }
        }
        
        
        
        /// Send a ball to hit the blocks
        /// - Parameters:
        ///   - anchor: AnchorEntity of the ARView
        ///   - entity: Entity on which the ball is to be thrown
        func sendBall(anchor: AnchorEntity, entity: Entity) {
            guard let view = self.view else {return}
            
            // Getting camera's position
            let translate = view.cameraTransform.translation
            
            let query: CollisionCastQueryType = .nearest
            let mask: CollisionGroup = .default

            let x = translate.x
            let y = translate.y
            let z = translate.z
            
            let transform: SIMD3<Float> = [x, y, z]
            
            // Getting the collsion ray cast
            let raycasts: [CollisionCastHit] = view.scene.raycast(
                from: transform,
                to: entity.position,
                query: query,
                mask: mask,
                relativeTo: nil)
            
            guard let raycast: CollisionCastHit = raycasts.first else { return }
            
            
            // Adding the ball Entity
            let ballEntity = ModelEntity(mesh: self.ball, materials: [self.materialSphere])
            ballEntity.name = "Ball"
            ballEntity.position = transform
            
            // Setting body and motion of the ball
            let size = ballEntity.visualBounds(relativeTo: ballEntity).extents
            let ballShape = ShapeResource.generateBox(size: size)
            let vectorDen: Float = pow(transform.x - entity.position.x, 2) + pow(transform.y - entity.position.y, 2) + pow(transform.z - entity.position.z, 2)
            ballEntity.collision = CollisionComponent(shapes: [ballShape])
            let body = PhysicsBodyComponent(
                massProperties: .init(shape: ballShape, mass: 75),
                material: nil,
                mode: .dynamic
            )
            let motion = PhysicsMotionComponent(
                linearVelocity: [raycast.distance * (entity.position.x - transform.x) * 10 / vectorDen, (raycast.distance * (entity.position.y - transform.y) * 10 / vectorDen) + 2, raycast.distance * (entity.position.z - transform.z) * 10 / vectorDen]
            )
            ballEntity.components.set(body)
            ballEntity.components.set(motion)

            
            // Adding the ball to the anchor
            anchor.addChild(ballEntity)
        }
        
        
        /// Create a stage for the game
        /// - Parameters:
        ///   - focusEntity: FocusEntity object from the FocusEntity package
        ///   - anchor: Anchor on which the stage is to be built
        func createStage(focusEntity: FocusEntity, anchor: AnchorEntity) {
            addBlock(focusEntity: focusEntity, anchor: anchor, verticle: true, x: -0.2, y: 0, z: 0)
            addBlock(focusEntity: focusEntity, anchor: anchor, verticle: true, x: 0.2, y: 0, z: 0)
            addBlock(focusEntity: focusEntity, anchor: anchor, verticle: false, x: 0, y: 0.5, z: 0)
            
            // Create a plane below the blocks
            let planeMesh = MeshResource.generatePlane(width: 2, depth: 2)
            let material = SimpleMaterial(color: .init(white: 1.0, alpha: 0.1), isMetallic: false)
            let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
            planeEntity.position = focusEntity.position
            planeEntity.physicsBody = PhysicsBodyComponent(massProperties: .default, material: nil, mode: .static)
            planeEntity.collision = CollisionComponent(shapes: [.generateBox(width: 2, height: 0.001, depth: 2)])
            planeEntity.position = focusEntity.position
            anchor.addChild(planeEntity)
        }
        
        
        /// Create a block relative to the FocusEntity according to the coordinates
        /// - Parameters:
        ///   - focusEntity: FocusEntity relative to which the x, y, z are given
        ///   - anchor: AnchorEntity on which the blocks are to be placed
        ///   - verticle: if the block is verticle or horizontal
        ///   - x: x co-ordinate
        ///   - y: y co-ordinate
        ///   - z: z co-ordinate
        func addBlock(focusEntity: FocusEntity, anchor: AnchorEntity, verticle: Bool, x: Float, y: Float, z: Float) {
            let deltaY: Float = verticle ? 0.3 : 0.1
            
            // Creating the block
            let blockEntity = ModelEntity(mesh: verticle ? self.blockVerticle: self.blockHorizontal, materials: [self.materialBlock])
            blockEntity.name = "Rectangular Block - " + (verticle ? "verticle" : "horizontal")
            blockEntity.setPosition(SIMD3<Float>(x: x, y: y + deltaY, z: z), relativeTo: focusEntity)
            anchor.addChild(blockEntity)
            
            // Setting gravity and collision for the block
            let size = blockEntity.visualBounds(relativeTo: blockEntity).extents
            let boxShape = ShapeResource.generateBox(size: size)
            blockEntity.collision = CollisionComponent(shapes: [boxShape])
            blockEntity.physicsBody = PhysicsBodyComponent(
                massProperties: .init(shape: boxShape, mass: 50),
                material: nil,
                mode: .dynamic
            )
        }
    }
}

