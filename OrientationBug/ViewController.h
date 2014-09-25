//
//  ViewController.h
//  OrientationBug
//
//  Created by Phillip on 24/09/14.
//  Copyright (c) 2014 Phillip. All rights reserved.
//


#import <UIKit/UIKit.h>

@class ImageScrollView;

@interface ViewController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate,UIWebViewDelegate>

{
    ImageScrollView *scrollView;
    UIImageView *imageView;
    
    //Bools
    BOOL pageControlBeingUsed;
    BOOL descriptionSelected;
    BOOL imagesSelected;
    BOOL shareSelected;
    
    //Images
    NSArray *photos;
    
    UISegmentedControl *segmentedControl;
}

@property (nonatomic, strong) UIView *descriptionSegmentView;
@property (nonatomic, strong) UIView *imageSegmentView;
@property (nonatomic, strong) UIView *shareSegmentView;

@property (nonatomic, strong) ImageScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIWebView* webView;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *imagesArray;

@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;


- (IBAction) changeSegment:(UISegmentedControl*)sender;

- (IBAction) showDescription;
- (IBAction) showImage;
- (IBAction) showShare;

@end

