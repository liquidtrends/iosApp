import UIKit


class ViewController: UIViewController,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate
{

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var selectImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func selectAnImage(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            println("Button capture")
            var imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            //imag.mediaTypes = [kUTTypeImage];
            imag.allowsEditing = false
            self.presentViewController(imag, animated: true, completion: nil)
        }
    }

    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
        //var tempImage:UIImage = editingInfo[UIImagePickerControllerOriginalImage] as UIImage
        mainImage.image=selectedImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    let context = CIContext(options: nil)
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == .MotionShake {
            // Create an image to filter
            let inputImage = CIImage(image: mainImage.image)
            
            // Create a random color to pass to a filter
            let randomColor = [kCIInputAngleKey: (Double(arc4random_uniform(314)) / 100)]
            
            // Apply a filter to the image
            let filteredImage = inputImage.imageByApplyingFilter("CIHueAdjust", withInputParameters: randomColor)
            
            // Render the filtered image
            let renderedImage = context.createCGImage(filteredImage, fromRect: filteredImage.extent())
            
            // Reflect the change back in the interface
            mainImage.image = UIImage(CGImage: renderedImage)
        }
    }
}
