//
//  yijianView.m
//  SlideMenu
//
//  Created by main on 15/9/17.
//  Copyright (c) 2015年 Aryan Ghassemi. All rights reserved.
//

#import "yijianView.h"
#import "AFHTTPRequestOperationManager.h"

@interface yijianView ()
@property (nonatomic,strong)NSArray *zhiwuArray;
@end

@implementation yijianView
@synthesize yijianTextView,shuomingTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.ViewD.layer.borderWidth = 1;
    self.ViewD.layer.borderColor = [UIColor colorWithRed:224/255.0 green:234/255.0 blue:243/255.0 alpha:1.0].CGColor;
    self.yijianTextView.delegate =self;
    self.shuomingTextView.delegate = self;
   
    self.yijianTextView.editable = YES;        //是否允许编辑内容，默认为“YES”
    self.shuomingTextView.editable = YES;
    self.shuomingTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.yijianTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.yijianTextView.layer.borderWidth = 1;
    self.yijianTextView.layer.borderColor = [UIColor colorWithRed:224/255.0 green:225/255.0 blue:228/255.0 alpha:1.0].CGColor;
    self.shuomingTextView.layer.borderWidth = 1;
    self.shuomingTextView.layer.borderColor = [UIColor colorWithRed:224/255.0 green:225/255.0 blue:228/255.0 alpha:1.0].CGColor;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textViewDidChange:(UITextView *)textView{
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    [self.yijianTextView resignFirstResponder];
    [self.shuomingTextView resignFirstResponder];
}

@end
