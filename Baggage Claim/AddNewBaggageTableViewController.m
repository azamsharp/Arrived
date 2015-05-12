//
//  AddNewBaggageTableViewController.m
//  Baggage Claim
//
//  Created by Mohammad AZam on 5/3/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import "AddNewBaggageTableViewController.h"

@interface AddNewBaggageTableViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic,weak) IBOutlet UITextField *nameTextField;
@property (nonatomic,weak) IBOutlet UITextField *uuIDTextField;
@property (nonatomic,weak) IBOutlet UITextField *majorValueTextField;
@property (nonatomic,weak) IBOutlet UITextField *minorValueTextField;

@property (nonatomic,weak) IBOutlet UIImageView *photoImageView;

@end

@implementation AddNewBaggageTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setup];
}

-(void) setup {
    
    _baggages = [NSMutableArray array];
    _imagePicker = [[UIImagePickerController alloc] init];
    
    _imagePicker.delegate = self;
    
    self.photoImageView.userInteractionEnabled = YES;
    [self registerGestureRecognizers];
}

-(void) registerGestureRecognizers {
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped:)];
    [self.photoImageView addGestureRecognizer:tapGestureRecognizer];
}

-(void) photoTapped:(UIGestureRecognizer *) recognizer {
    
    [self showPhotoSelectionOptions];
    
}

-(void) showPhotoSelectionOptions {
    
    _actionSheet = [[UIActionSheet alloc] initWithTitle:@"Attach Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Pick from Library",@"Take New Picture",nil];
    
    [_actionSheet showInView:self.view];
}

-(void) openCamera {
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [_imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        }
    else
        {
            [_imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

-(void) openLibrary {

    [_imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imageTaken = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    
    NSString *imageName = [imagePath lastPathComponent];
    
    [self.photoImageView setImage:imageTaken];
    
    // should we save it in the photos album
    // only save when not taken from the photo album
    if(![imageName isEqualToString:@"asset.JPG"])
    {
        UIImageWriteToSavedPhotosAlbum(imageTaken, self, nil, nil);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        // pick picture from library
        [self openLibrary];
    }
    else if(buttonIndex == 1) {
        // take a picture
        [self openCamera];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) saveBaggage {
    
    _baggages = [BaggageService getAll];
    
    Baggage *baggage = [[Baggage alloc] init];
    baggage.name = self.nameTextField.text;
    baggage.uuid = [[NSUUID alloc] initWithUUIDString:self.uuIDTextField.text];
    baggage.majorValue = (int) [self.majorValueTextField.text integerValue];
    baggage.minorValue = (int) [self.minorValueTextField.text integerValue];
    baggage.photoPath = [ImageService saveImageIntoDocumentsDirectory:self.photoImageView.image];
    baggage.hasArrived = NO;
    baggage.hasNotificationBeenSent = NO; 
    
    [BaggageService save:baggage];
    
    if(self.delegate != nil) {
        
        [self.delegate addNewBaggageTableViewControllerDidClose:self];
    }

}

-(IBAction) close {
    
    if(self.delegate != nil) {
        
        [self.delegate addNewBaggageTableViewControllerDidClose:self];
    }
}

@end
