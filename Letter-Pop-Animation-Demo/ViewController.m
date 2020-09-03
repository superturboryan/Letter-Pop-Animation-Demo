//
//  ViewController.m
//  Letter-Pop-Animation-Demo
//
//  Created by Ryan David Forsyth on 2020-09-02.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

#import "ViewController.h"
#import "AnimatedPopStackView.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textInput;
@property (weak, nonatomic) IBOutlet UIButton *animateButton;
@property (weak, nonatomic) IBOutlet UISwitch *animatedSwitch;

@property (weak, nonatomic) IBOutlet AnimatedPopStackView *animatedPopStackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapper];
    
    [self setupView];
}

- (void)setupView {
    self.textInput.delegate = self;
    
    self.animateButton.layer.cornerRadius = 5.0;
    
}

- (IBAction)tappedAnimateButton:(UIButton *)sender {
    [self.animatedPopStackView clear];
    [self.animatedPopStackView addLabelsForString:self.textInput.text animated:self.animatedSwitch.on];
    self.textInput.text = @"";
    [self dismissKeyboard];
}

-(void)dismissKeyboard {
    [self.textInput resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self tappedAnimateButton:nil];
    return YES;
}

@end
