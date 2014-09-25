//
//  ImageScrollView.m
//  OrientationBug
//
//  Created by Rob Mayoff on 9/25/14.
//  Copyright (c) 2014 Phillip. All rights reserved.
//

#import "ImageScrollView.h"
#import <tgmath.h>

@implementation ImageScrollView {
    NSMutableArray *imageSubviews;
    CGSize priorSize;
    CGFloat pageNumber;
    BOOL needsToSyncSubviewsWithImages : 1;
}

#pragma mark - Public API

@synthesize images = _images;

- (void)setImages:(NSArray *)images {
    _images = [images copy];
    needsToSyncSubviewsWithImages = YES;
}

#pragma mark - UIView overrides

- (void)layoutSubviews {
    [super layoutSubviews];
    if (needsToSyncSubviewsWithImages) {
        [self syncSubviewsWithImages];
    }
    if (needsToSyncSubviewsWithImages || !CGSizeEqualToSize(self.bounds.size, priorSize)) {
        [self layoutForNewSize];
    }
    needsToSyncSubviewsWithImages = NO;
    priorSize = self.bounds.size;
    [self updatePageNumber];
}

#pragma mark - Implementation details

- (void)syncSubviewsWithImages {
    [self ensureImageSubviewsArrayExists];
    [self putImagesInSubviews];
    [self removeExtraSubviews];
}

- (void)ensureImageSubviewsArrayExists {
    if (imageSubviews == nil) {
        imageSubviews = [NSMutableArray arrayWithCapacity:self.images.count];
    }
}

- (void)putImagesInSubviews {
    [self.images enumerateObjectsUsingBlock:^(id obj, NSUInteger i, BOOL *stop) {
        [self putImage:obj inSubviewAtIndex:i];
    }];
}

- (void)removeExtraSubviews {
    if (imageSubviews.count > self.images.count) {
        [imageSubviews removeObjectsInRange:NSMakeRange(self.images.count, imageSubviews.count - self.images.count)];
    }
}

- (void)putImage:(UIImage *)image inSubviewAtIndex:(NSUInteger)i {
    UIImageView *imageView = [self imageViewAtIndex:i];
    imageView.image = image;
}

- (UIImageView *)imageViewAtIndex:(NSUInteger)i {
    while (i >= imageSubviews.count) {
        UIView *view = [[UIImageView alloc] init];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:view];
        [imageSubviews addObject:view];
    }
    return imageSubviews[i];
}

- (void)layoutForNewSize {
    [self setSubviewFramesAndContentSize];
    [self alignToNearestPage];
}

- (void)setSubviewFramesAndContentSize {
    CGRect frame = self.bounds;
    frame.origin = CGPointZero;
    for (UIView *subview in imageSubviews) {
        subview.frame = frame;
        frame.origin.x += frame.size.width;
    }
    self.contentSize = CGSizeMake(frame.origin.x, frame.size.height);
}

- (void)alignToNearestPage {
    self.contentOffset = CGPointMake(pageNumber * self.bounds.size.width, 0);
}

- (void)updatePageNumber {
    // Note that self.contentOffset == self.bounds.origin.
    CGRect bounds = self.bounds;
    pageNumber = fmin(round(bounds.origin.x / bounds.size.width), self.images.count - 1);
}

@end
