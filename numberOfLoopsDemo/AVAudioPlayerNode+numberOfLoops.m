//
//  NSObject+numberOfLoops.m
//  numberOfLoopsDemo
//
//  Created by DP Bhatt on 08/06/2018.
//  Copyright © 2018 Sensus ApS. All rights reserved.
//

#import "AVAudioPlayerNode+numberOfLoops.h"

@implementation AVAudioPlayerNode (numberOfLoops)
- (void)scheduleBuffer:(AVAudioPCMBuffer *)buffer _:(NSInteger)numberOfLoops{
    for (int i = 0; i<numberOfLoops; i++) {
        [self scheduleBuffer:buffer completionHandler:nil];
    }
}
@end
