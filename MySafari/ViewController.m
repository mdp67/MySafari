//
//  ViewController.m
//  MySafari
//
//  Created by Mark Porcella on 5/13/15.
//  Copyright (c) 2015 Mark Porcella. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *networkActivityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@property float lastContentOffset;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkActivityIndicator.hidden = true;
    self.webView.scrollView.delegate = self;

    self.lastContentOffset = self.webView.scrollView.contentOffset.y;

}


- (IBAction)onBackButtonPressed:(UIButton *)sender {


    [self.webView goBack];

}

- (IBAction)onForwardButtonPressed:(UIButton *)sender {

    [self.webView goForward];
}


- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {

    [self.webView stopLoading];
}

- (IBAction)onReloadButtonPressed:(UIButton *)sender {

    [self.webView reload];
}
- (IBAction)onNewFeatureButtonPressed:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Coming Soon" message:@"new ways to waste your time!" delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil, nil];

    [alertView show];
}

#pragma mark -TextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (![self.urlTextField.text hasPrefix:@"http://"] && ![self.urlTextField.text hasPrefix:@"https://"]) {
        self.urlTextField.text = [@"http://" stringByAppendingString:self.urlTextField.text];
    }
    [self loadWebRequestWithText:self.urlTextField.text];
    return TRUE;

}


- (void) loadWebRequestWithText:(NSString *)text {
    NSURL *url = [[NSURL alloc] initWithString:text];
    NSURLRequest *urlRequest = [[NSURLRequest alloc ] initWithURL:url];
    [self.webView loadRequest:urlRequest];
}

#pragma mark -WebViewDelegate Methods

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.networkActivityIndicator startAnimating];
    self.networkActivityIndicator.hidden = false;

    if ([self.webView canGoBack]) {
        self.backButton.enabled = true;
    } else {
        self.backButton.enabled = false;
    }

    if ([self.webView canGoForward]) {
        self.forwardButton.enabled = true;
    } else {
        self.forwardButton.enabled = false;
    }

}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.networkActivityIndicator stopAnimating];
    self.networkActivityIndicator.hidden = true;
}


#pragma mark -ScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.lastContentOffset < self.webView.scrollView.contentOffset.y) {
        self.urlTextField.hidden = true;
    }
    else {
        self.urlTextField.hidden = false;
    }

    self.lastContentOffset = self.webView.scrollView.contentOffset.y;


}


@end
