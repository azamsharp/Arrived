//
//  BaggageDetailsViewController.m
//  Arrived
//
//  Created by Mohammad AZam on 5/13/15.
//  Copyright (c) 2015 AzamSharp Consulting LLC. All rights reserved.
//

#import "BaggageDetailsViewController.h"

@interface BaggageDetailsViewController ()

@end

@implementation BaggageDetailsViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self setup];
}

-(void) setup {
    
    self.title = self.baggage.name; 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) close {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
