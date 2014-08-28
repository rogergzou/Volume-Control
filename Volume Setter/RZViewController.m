//
//  RZViewController.m
//  Volume Setter
//
//  Created by Roger on 8/26/14.
//  Copyright (c) 2014 Roger Zou. All rights reserved.
//

#import "RZViewController.h"

@interface RZViewController ()

@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UITextField *volumeTextField;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation RZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 575)];
    //self.scrollView.contentSize = self.view.frame.size;
    
    //to resign keyboard. One liner lol. http://stackoverflow.com/questions/5306240/iphone-dismiss-keyboard-when-touching-outside-of-textfield
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    //fml keyboardDismissMode only in scrollView
    scroller.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;

    //self.view = self.scrollView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)textChanged:(UITextField *)sender {
    if ([self isNumeric:sender.text])
        self.volumeSlider.value = [sender.text floatValue];
    else
        sender.text = @"";
}

- (IBAction)sliderChanged:(UISlider *)sender {
    self.volumeTextField.text = [NSString stringWithFormat:@"%f",sender.value];
}

// http://stackoverflow.com/questions/7153376/detect-if-nsstring-is-a-float-number
-(bool) isNumeric:(NSString*) checkText{
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    //Set the locale to US
    [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    //Set the number style to Scientific
    [numberFormatter setNumberStyle:NSNumberFormatterScientificStyle];
    NSNumber* number = [numberFormatter numberFromString:checkText];
    if (number != nil) {
        return true;
    }
    return false;
}

@end
