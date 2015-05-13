//
//  ViewController.m
//  MySafari
//
//  Created by Mark Porcella on 5/13/15.
//  Copyright (c) 2015 Mark Porcella. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *networkActivityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkActivityIndicator.hidden = true;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

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
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.networkActivityIndicator stopAnimating];
    self.networkActivityIndicator.hidden = true;
}

@end
