//
//  ViewReusePool.m
//  MyStudyiOS
//
//  Created by 御前崎悠羽 on 2024/5/20.
//

#import "ViewReusePool.h"

// ViewReusePool 类拓展。
@interface ViewReusePool ()

// 等待使用的队列。
@property (nonatomic, strong) NSMutableSet *waitUsedQueue;
// 使用中的队列。
@property (nonatomic, strong) NSMutableSet *usingQueue;

@end

@implementation ViewReusePool

- (id)init {
    self = [super init];
    if (self) {
        _waitUsedQueue = [NSMutableSet set];
        _usingQueue = [NSMutableSet set];
    }
    return self;
}

- (UIView *)dequeueReuseableView {
    UIView *view = [_waitUsedQueue anyObject];
    if (view == nil) {
        return nil;
    } else {
        // 进行队列移动。
        [_waitUsedQueue removeObject:view];
        [_usingQueue addObject:view];
        return view;
    }
}

- (void)addUsingView:(UIView *)view {
    if (view == nil) {
        return;
    }
    [_usingQueue addObject:view];
}

- (void)reset {
    UIView *view = nil;
    while ((view = [_usingQueue anyObject])) {
        // 从使用中队列移除。
        [_usingQueue removeObject:view];
        // 加入等待使用的队列。
        [_waitUsedQueue addObject:view];
    }
}

@end
