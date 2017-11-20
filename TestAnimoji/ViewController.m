//
//  ViewController.m
//  TestAnimoji
//
//  Created by kevin on 2017/11/20.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "ViewController.h"
#import "AVTPuppet.h"
#import "AVTPuppetView.h"

@interface ViewController ()

@property (nonatomic, copy) NSArray <NSString *> *puppetNames;
@property (nonatomic, copy) NSString *puppetName;
@property (nonatomic, strong) AVTPuppet *puppet;
@property (nonatomic, strong) AVTPuppetView *puppetView;
@property (nonatomic, strong) AVTAvatarInstance *avatarInstance;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.puppetNames = [ASPuppet puppetNames];
    [self build];
}

- (void)build
{
    if (self.puppetView) return;
    
    self.puppetView = [AVTPuppetView new];
    self.puppetView.frame = self.view.bounds;
    self.puppetView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.puppetView.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:self.puppetView atIndex:0];

    ARConfiguration *config = [self.puppetView.arSession.configuration copy];
    config.providesAudioData = NO;
    [self.puppetView.arSession runWithConfiguration:config options:ARSessionRunOptionResetTracking|ARSessionRunOptionRemoveExistingAnchors];
    
    [self resetAvatraWithAnimation:NO];
}

- (void)resetAvatraWithAnimation:(BOOL)animation
{
    NSUInteger index = (NSUInteger)arc4random_uniform(self.puppetNames.count);
    _puppetName = [self.puppetNames objectAtIndex:index];
    self.avatarInstance = (AVTAvatarInstance *)[AVTPuppet puppetNamed:_puppetName options:nil];
    [self.puppetView setAvatarInstance:_avatarInstance];
    
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            self.puppetView.alpha = 0;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3  animations:^{
                self.puppetView.alpha = 1;
            }];
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self resetAvatraWithAnimation:YES];
}

@end
