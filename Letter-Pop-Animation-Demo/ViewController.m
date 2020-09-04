//
//  ViewController.m
//  Letter-Pop-Animation-Demo
//
//  Created by Ryan David Forsyth on 2020-09-02.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

#import "ViewController.h"
#import "AnimatedPopStackView.h"
#import "RFSKScene.h"
#import <SpriteKit/SpriteKit.h>

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textInput;
@property (weak, nonatomic) IBOutlet UIButton *animateButton;
@property (weak, nonatomic) IBOutlet UISwitch *animatedSwitch;

@property (weak, nonatomic) IBOutlet AnimatedPopStackView *animatedPopStackView;

@property (strong, nonatomic) SKView *skView;

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
    [self loadSKView];
    [self loadEmptyScene];
}

- (void)loadSKView {
    self.skView = [[SKView alloc]initWithFrame:self.view.frame];
    self.skView.allowsTransparency = YES;
    [self.view insertSubview:self.skView atIndex:0];
}

- (IBAction)tappedAnimateButton:(UIButton *)sender {
    [self.animatedPopStackView clear];
    [self.animatedPopStackView addLabelsForString:self.textInput.text animated:self.animatedSwitch.on completion:^{
        [self playConfetti];
    }];
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

- (void)loadEmptyScene {
    SKScene *emptyScene = [[SKScene alloc]init];
    emptyScene.backgroundColor = UIColor.clearColor;
    [self.skView presentScene:emptyScene];
    [self.view layoutIfNeeded];
}

- (void)playConfetti {
    RFSKScene *confettiScene = [[RFSKScene alloc] initWithSize:CGSizeMake(self.view.frame.size.width,
                                                                          self.view.frame.size.height)];
    // Confetti set up with multiple emitters
    [confettiScene addConfettiEmitterWithPosition: CGPointMake(self.animatedPopStackView.center.x,
                                                               self.animatedPopStackView.center.y - 10)]; 
    [self.skView presentScene:confettiScene];
}

@end
