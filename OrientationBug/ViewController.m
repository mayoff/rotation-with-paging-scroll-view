//
//  ViewController.m
//  OrientationBug
//
//  Created by Phillip on 24/09/14.
//  Copyright (c) 2014 Phillip. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

@synthesize  imageView , scrollView, imageSegmentView, descriptionSegmentView, pageControl, segmentedControl, webView, imagesArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


#pragma mark - View layout and configuration

-(void)configureSegmentedControl{
    
    [segmentedControl setTitle:NSLocalizedString(@"Description", nil) forSegmentAtIndex:0];
    [segmentedControl setTitle:NSLocalizedString(@"Image", nil) forSegmentAtIndex:1];
    [segmentedControl setTitle:NSLocalizedString(@"Share", nil) forSegmentAtIndex:2];
    
    [segmentedControl setSelectedSegmentIndex:0];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;

}


-(void)configureTabs{
    CGRect viewsFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.descriptionSegmentView = [[UIView alloc] initWithFrame:viewsFrame];
    self.imageSegmentView = [[UIView alloc] initWithFrame:viewsFrame];
    self.shareSegmentView = [[UIView alloc] initWithFrame:viewsFrame];
    
    self.descriptionSegmentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageSegmentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.shareSegmentView.translatesAutoresizingMaskIntoConstraints = NO;

    
    //Configuring
    self.descriptionSegmentView.hidden = NO;
    self.imageSegmentView.hidden = YES;
    self.shareSegmentView.hidden = YES;
    
    [self.view addSubview:self.descriptionSegmentView];
    [self.view addSubview:self.imageSegmentView];
    [self.view addSubview:self.shareSegmentView];
    
    NSDictionary *descriptionView = @{@"descriptionView" : self.descriptionSegmentView};
    NSDictionary *imageTabView = @{@"imagesView" : self.imageSegmentView};
    NSDictionary *shareView = @{@"shareView" : self.shareSegmentView};
    
    NSArray* constraintDesc_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-65-[descriptionView]-3-|" options:0 metrics:nil views:descriptionView];
    NSArray* constraintDesc_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[descriptionView]-0-|" options:0 metrics:nil views:descriptionView];
    
    NSArray* constraintImage_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-65-[imagesView]-3-|" options:0 metrics:nil views:imageTabView];
    NSArray* constraintImage_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imagesView]-0-|" options:0 metrics:nil views:imageTabView];
    
    NSArray* constraintShare_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-65-[shareView]-3-|" options:0 metrics:nil views:shareView];
    NSArray* constraintShare_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[shareView]-0-|" options:0 metrics:nil views:shareView];
    
    [self.view addConstraints:constraintDesc_V];
    [self.view addConstraints:constraintDesc_H];
    [self.view addConstraints:constraintImage_V];
    [self.view addConstraints:constraintImage_H];
    [self.view addConstraints:constraintShare_V];
    [self.view addConstraints:constraintShare_H];
}

-(void)configureDescriptionTab{
   
    NSString *descr = [NSString stringWithFormat:@"<html><head><style> html{-webkit-text-size-adjust:none;} body{ word-wrap: normal; background-color: transparent; font-size:17; font-family: %@; color: black;} strong{font-family: %@; font-size:17;} pre{overflow:auto;} code{font-family: Menlo; font-size:15; background:#ededed; border: 1px solid #ddd;}</style></head><body style='background-color: transparent;'><p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc</p></body></html>",[UIFont systemFontOfSize:14],[UIFont boldSystemFontOfSize:14]];
    
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.descriptionSegmentView.frame.size.width,self.descriptionSegmentView.frame.size.height)];
    [webView setOpaque:NO];
    webView.scrollView.backgroundColor = [UIColor clearColor];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.scrollsToTop = YES;
    webView.backgroundColor = [UIColor clearColor];
    webView.delegate = self;
    webView.scrollView.scrollEnabled = TRUE;
    webView.scrollView.bounces = YES;
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [webView loadHTMLString:descr baseURL:nil];
    [self.descriptionSegmentView addSubview:webView];
    
    
    NSDictionary *view = NSDictionaryOfVariableBindings(webView);
    
    [self.descriptionSegmentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[webView]|" options:0 metrics:nil views:view]];
    
    [self.descriptionSegmentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[webView]|" options:0 metrics:nil views:view]];
    
}

-(void)configureImageTab{
    //Page control
    pageControl = [UIPageControl new];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    

    //Configuring scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.imageSegmentView.frame.size.width, self.imageSegmentView.frame.size.height-pageControl.frame.size.height)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Adding imageURLS to array
    photos = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"createBootableUSBInstallDrive1"],[UIImage imageNamed:@"createBootableUSBInstallDrive2"],[UIImage imageNamed:@"createBootableUSBInstallDrive3"], nil];
    
    //Actual setup -> scrollView adding imageView as subview with all the images
  
    for (int i =0; i< photos.count; i++){
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        //imageView setup
        imageView = [[UIImageView alloc]initWithFrame:frame];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        imageView.translatesAutoresizingMaskIntoConstraints = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //Setting images
        [imageView setImage:[photos objectAtIndex:i]];
        
        [self.scrollView addSubview:imageView];
    }
    
    pageControl.numberOfPages = [photos count];
    
    [self.imageSegmentView addSubview:self.scrollView];
    [self.imageSegmentView addSubview:pageControl];
    
    
    NSDictionary *views = @{@"pageControl" : pageControl, @"scrollView" : self.scrollView};
    
    [self.imageSegmentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pageControl]-0-|" options:0 metrics:nil views:views]];
    [self.imageSegmentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:views]];
    
    [self.imageSegmentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]-1-[pageControl]-1-|" options:0 metrics:nil views:views]];
    
    [pageControl addConstraint:[NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.imageSegmentView attribute:NSLayoutAttributeHeight multiplier:0 constant:30]];
}

#pragma mark - scrollView delegate -

-(void)scrollViewDidScroll:(UIScrollView *)sView{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor ((self.scrollView.contentOffset.x - pageWidth /2) /pageWidth) +1;
    self.pageControl.currentPage = page;
}

-(IBAction)changePage {
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    pageControlBeingUsed = NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    pageControlBeingUsed = NO;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return imageView;
}


#pragma mark - webView delegate -

-(void)webViewDidFinishLoad:(UIWebView *)weView{
    [weView.scrollView setContentSize:CGSizeMake(weView.frame.size.width, weView.scrollView.contentSize.height)];
}

- (NSString *)flattenHTML:(NSString*)html{
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"<" intoString:NULL];
        [theScanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",text] withString:@""];
    }
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
    
}

#pragma mark - View cycle -

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (navigationType == UIWebViewNavigationTypeLinkClicked){
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    
    return YES;
}


-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * photos.count, 1);
}

-(IBAction)changeSegment:(UISegmentedControl*)sender{
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self showDescription];
            break;
        case 1:
            [self showImage];
            break;
        case 2:
            [self showShare];
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureSegmentedControl];
    [self configureTabs];
    [self configureDescriptionTab];
    [self configureImageTab];
    }


#pragma mark - Tab switching -

- (IBAction)showDescription {
    //Setting the flag
    descriptionSelected = YES;
    [segmentedControl setSelectedSegmentIndex:0];
    
    //Configuring
    self.descriptionSegmentView.hidden = NO;
    self.imageSegmentView.hidden = YES;
    self.shareSegmentView.hidden = YES;
    pageControl.hidden = YES;
    //Saving status
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:0] forKey:@"segmentIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //Remove share menu if present
    // [self removeShareMenu];
}


- (IBAction)showImage {
    //Setting the flag
    imagesSelected = YES;
    [segmentedControl setSelectedSegmentIndex:1];
    
    //Configuring
    self.descriptionSegmentView.hidden = YES;
    self.imageSegmentView.hidden = NO;
    self.shareSegmentView.hidden = YES;
    pageControl.hidden = NO;
    //Saving status
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:1] forKey:@"segmentIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)showShare {
    [segmentedControl setSelectedSegmentIndex:2];
    
    //Setting the flag
    shareSelected = YES;
    pageControl.hidden = YES;
    
    //Configuring
    self.descriptionSegmentView.hidden = YES;
    self.imageSegmentView.hidden = YES;
    self.shareSegmentView.hidden = NO;
    
    //Saving status
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:2] forKey:@"segmentIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)shouldAutorotate{
    return YES;
}


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
}


@end