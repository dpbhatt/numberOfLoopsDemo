//
//  NSObject+numberOfLoops.h
//  numberOfLoopsDemo
//
//  Created by DP Bhatt on 08/06/2018.
//  Copyright © 2018 Sensus ApS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AVAudioPlayerNode (numberOfLoops)
- (void)scheduleBuffer:(AVAudioPCMBuffer *)buffer _:(NSInteger) numberOfLoops;
@end
