//
//  NHGCountdown.m
//  NHGCountdown
//
//  Created by Nick Griffith on 4/19/15.
//  Copyright (c) 2015 nhg. All rights reserved.
//

#import "NHGCountdown.h"

@interface NHGCountdown()

@property NSTimer *timer;
@property NSTimer *updateTimer;
@property (readwrite) NSTimeInterval interval;

@end

@implementation NHGCountdown

- (instancetype)initWithDelegate:(id<NHGCountdownDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

+ (instancetype)countdownWithDelegate:(id<NHGCountdownDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

- (void)startCountdownWithInterval:(NSTimeInterval)interval ticks:(NSUInteger)ticks {
    self.interval = interval;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(interval * ticks) target:self selector:@selector(countdownComplete:) userInfo:nil repeats:NO];
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(countdownUpdate:) userInfo:nil repeats:YES];
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
    if ([self.delegate respondsToSelector:@selector(countdownUpdate:)]) {
        [self.delegate countdownUpdate:self];
    }
}

- (void)countdownComplete:(NSTimer *)timer {
    [self.updateTimer invalidate];
    [self.delegate countdownComplete:self];
}

@end
