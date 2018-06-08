//
//  ViewController.m
//  numberOfLoopsDemo
//
//  Created by DP Bhatt on 08/06/2018.
//  Copyright © 2018 Sensus ApS. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AVAudioPlayerNode+numberOfLoops.h"

@interface ViewController ()

@end
AVAudioEngine * engine;
AVAudioPlayerNode *audioPlayer;
int speedIncrement = 1.0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playSound:(UIButton *)sender {
    NSInteger i = 0;
    
    while (i < 10){
         [self play:sender.tag];
        [NSThread sleepForTimeInterval:2.0f];
        i++;
    }
   
}

-(void) play: (NSInteger) numberOfLoops {
    engine = [[AVAudioEngine alloc] init];
    audioPlayer = [[AVAudioPlayerNode alloc] init];
    audioPlayer.volume = 10.0;
    
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"Beep" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath: audioPath];
    AVAudioFile *file = [[AVAudioFile alloc] initForReading:url error:nil];
    
    AVAudioPCMBuffer *buffer = [[AVAudioPCMBuffer alloc] initWithPCMFormat:file.processingFormat frameCapacity:(AVAudioFrameCount)[file length]];
    [file readIntoBuffer:buffer error:nil];
    
    AVAudioUnitTimePitch *pitch = [[AVAudioUnitTimePitch alloc] init];
    AVAudioUnitVarispeed *speed = [[AVAudioUnitVarispeed alloc] init];
    pitch.pitch = speedIncrement * (-500);
    speed.rate = speedIncrement;
    
    [engine attachNode:audioPlayer];
    [engine attachNode:pitch];
    [engine attachNode:speed];
    
    [engine connect:audioPlayer to:speed format:file.processingFormat];
    [engine connect:speed to:pitch format:file.processingFormat];
    [engine connect:pitch to:engine.mainMixerNode format:file.processingFormat];
    
   
    [audioPlayer scheduleBuffer:buffer _:numberOfLoops];
    
    [engine prepare];
    [engine startAndReturnError:nil];
    [audioPlayer play];
}

@end
