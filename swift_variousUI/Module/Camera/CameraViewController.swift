import AVFoundation
import RxCocoa
import RxSwift
import UIKit

class CameraViewController: UIViewController {
    @IBOutlet private weak var previewLayerFrame: UIView!
    @IBOutlet private weak var shutterButton: UIButton!
    
    private var captureSession: AVCaptureSession?
    private var cameraDevice: AVCaptureDevice?
    private var photoOutput: AVCapturePhotoOutput?
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupUI()
    }
}

// MARK: - Data

extension CameraViewController {
    private func setupData() {
        checkCameraStatus()
    }
    
    private func checkCameraStatus() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { isGranted in
                if isGranted {
                    self.setupCameraCaptureSession()
                }
            }
        case .restricted, .denied:
            print("Permission Denied")
        case .authorized:
            setupCameraCaptureSession()
        @unknown default:
            return
        }
    }
    
    private func takePhoto() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
}

// MARK: - UI

extension CameraViewController {
    private func setupUI() {
        setupButton()
    }
    
    private func setupCameraCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession?.beginConfiguration()
        captureSession?.sessionPreset = .photo
        
        cameraDevice = AVCaptureDevice.default(
            AVCaptureDevice.DeviceType.builtInWideAngleCamera,
            for: AVMediaType.video,
            position: .back
        )
        
        guard let captureSession = captureSession, let cameraDevice = cameraDevice else {
            captureSession?.commitConfiguration()
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: cameraDevice)
        } catch {
            captureSession.commitConfiguration()
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            captureSession.commitConfiguration()
            return
        }
        
        photoOutput = AVCapturePhotoOutput()
        if captureSession.canAddOutput(photoOutput!) {
            captureSession.addOutput(photoOutput!)
        }
        
        captureSession.commitConfiguration()
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        previewLayerFrame.layer.addSublayer(previewLayer)
        previewLayerFrame.frame = previewLayer.bounds
        captureSession.startRunning()
    }
    
    private func setupButton() {
        shutterButton.rx.tap
            .subscribe { _ in
                self.takePhoto()
            }.disposed(by: disposeBag)
    }
}

// MARK: - AVCapturePhotoCaptureDelegate

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?
    ) {
        if let imageData = photo.fileDataRepresentation() {
            let uiImage = UIImage(data: imageData)
        }
    }
}

extension CameraViewController: StoryboardInstance {
    static func newInstance() -> CameraViewController {
        let controller = UIStoryboard(
            name: CameraViewController.storyboardName(),
            bundle: nil
        ).instantiateViewController(withIdentifier: CameraViewController.identifer())
        as! CameraViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Camera"
    }
    
    static func identifer() -> String {
        return String(describing: CameraViewController.self)
    }
}
