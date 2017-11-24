#import "AddProductyViewController.h"
#define URL_API_CATEGORIES @"http://artdinamica.com/cice/categorias.php"
#define URL_API_ADD_PRODUCT @"http://artdinamica.com/cice/productoNuevo.php"
#define URL_API_DOWNLOAD @"http://artdinamica.com/cice/archivo.pptx"

@implementation AddProductyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.buttonCamera.enabled = false;
        self.buttonCamera.alpha = 0.5;
    }
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config];
    NSURL *url = [NSURL URLWithString:URL_API_CATEGORIES];
    NSURLSessionTask *task = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //check status code.
        if (error) {
            NSLog(@"Error on task: %@", error.description);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (httpResponse.statusCode == 200) {
                NSError *jsonError = nil;
                categoriesArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                NSLog(@"categories --> %@", categoriesArray);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.pickerViewCategory reloadAllComponents];
                });
            } else {
                NSLog(@"status: %ld", httpResponse.statusCode);
            }
        }
    }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - <UIPickeerViewDataSource>
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [categoriesArray count];
}

-(UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.text = [[categoriesArray objectAtIndex:row] objectForKey:@"nombre"];
    return label;
}

-(CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}


#pragma mark - <UIPickerDelegate>
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component { }



#pragma mark - actions
- (IBAction)actionChooseImageCamera:(id)sender {
    [self takePicture:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)actionChooseImageGallery:(id)sender {
    [self takePicture:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)actionSave:(id)sender {
    NSString *deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *boundary = @"ValorSeparadorDeParametrosPost";
    NSMutableData *body = [[NSMutableData alloc] init];
    //UUID
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"UUID\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", deviceId] dataUsingEncoding:NSUTF8StringEncoding]];
    //TITULO
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"nombre\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", self.textViewName.text] dataUsingEncoding:NSUTF8StringEncoding]];
    //DESCRIPTION
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"descripcion\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", self.textViewDescription.text] dataUsingEncoding:NSUTF8StringEncoding]];
    //DESCRIPTION
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"descripcion\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", self.textViewDescription.text] dataUsingEncoding:NSUTF8StringEncoding]];

    //CATEGORY
    NSDictionary *categorySelected = [categoriesArray objectAtIndex:[self.pickerViewCategory selectedRowInComponent:0]];
    NSString *categorySelectedName = [categorySelected objectForKey:@"id"];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"categoria\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", categorySelectedName] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //IMAGE
    NSData *imageData = UIImageJPEGRepresentation(self.imageViewProduct.image, 0.9);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\"imagen.jpg\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData: imageData];
        [body appendData: [[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];

    }
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary], @"Content-Type" ,nil];
    //possible headers:
    //Accept = application/json
    //Api-key = 54654654654654
    NSURL *url = [NSURL URLWithString:URL_API_ADD_PRODUCT];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = body;
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURLSessionDataTask *task = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *alertTitle = @"save";
        NSString *alertDesc = @"Save ok!!";
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSError *jsonError;
            NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            //
            //NSLog(dataStr);
            if (jsonError) {
                alertDesc = [NSString stringWithFormat:@"save done %i %@", httpResponse.statusCode, jsonError.localizedDescription];
            } else {
                alertDesc = [NSString stringWithFormat:@"save done %i %@", httpResponse.statusCode, jsonResults];
            }
        
        } else {
            alertDesc = error.localizedDescription;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:alertDesc delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles: nil];
            [alertView show];
        });
    }];
    [task resume];
}
- (IBAction)actionCancel:(id)sender {

}

- (IBAction)downloadImage:(id)sender {
    //set loading bar.
    //
    self.progressBar
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:URL_API_DOWNLOAD];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
    [downloadTask resume];
}

#pragma mark - NSURLSessionDelegate


#pragma mark - private methods
-(void) takePicture:(UIImagePickerControllerSourceType) sourceType {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:true completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(nonnull UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    self.imageViewProduct.image = image;
    [picker dismissViewControllerAnimated:true completion:nil];
    //float finalHeight = self.imageView.frame.size.width * image.size.height / image.size.width;
    //CGRect imageFrame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.imageView.frame.size.width, finalHeight);
    //self.imageView.frame = imageFrame;
}

@end
