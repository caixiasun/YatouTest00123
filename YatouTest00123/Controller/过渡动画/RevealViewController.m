//
//  RevealViewController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/7.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "RevealViewController.h"

@interface RevealViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation RevealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.petCard.name;
    self.imageView.image = self.petCard.image;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
