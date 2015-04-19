//
//  NHGBlockCountdown.m
//  NHGCountdown
//
//  Created by Nick Griffith on 4/19/15.
//  Copyright (c) 2015 nhg. All rights reserved.
//

#import "NHGBlockCountdown.h"

@interface NHGBlockCountdown()

@property NSTimer *timer;
@property NSTimer *updateTimer;
@property (readwrite) NSTimeInterval interval;
@property (copy) NHGCountdownCompletion completion;
@property (copy) NHGCountdownUpdate update;

@end

@implementation NHGBlockCountdown

+ (instancetype)countdown {
    return [[self alloc] init];
}

- (void)startCountdownWithInterval:(NSTimeInterval)interval ticks:(NSUInteger)ticks update:(NHGCountdownUpdate)update completion:(NHGCountdownCompletion)completion {
    self.completion = completion;
    self.update = update;
    self.interval = interval;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(interval * ticks) target:self selector:@selector(countdownComplete:) userInfo:nil repeats:NO];
    if (self.update) {
        self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(countdownUpdate:) userInfo:nil repeats:YES];
    }
}

- (void)stopCountdown {
    [self.updateTimer invalidate];
    [self.timer invalidate];
}

- (NSUInteger)ticksRemaining {
    if (self.timer.isValid) {
        NSTimeInterval timeRemaining = [self.timer.fireDate timeIntervalSinceDate:[NSDate date]];
        return timeRemaining / self.interval;
    } else {
        return 0;
    }
}

- (void)countdownUpdate:(NSTimer *)timer {
    if (self.update) {
        self.update(self.ticksRemaining);
    }
}

- (void)countdownComplete:(NSTimer *)timer {
    [self.updateTimer invalidate];
    if (self.completion) {
        self.completion();
    }
    
    self.update = nil;
    self.completion = nil;
}

@end