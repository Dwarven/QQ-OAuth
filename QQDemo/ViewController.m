//
//  ViewController.m
//  QQDemo
//
//  Created by 杨建亚 on 14-7-10.
//  Copyright (c) 2014年 Dwarven. All rights reserved.
//

#import "ViewController.h"
#import "TencentAccess.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClicked:(id)sender {
    [[TencentAccess defaultAccess] login:^(BOOL succeeded, id object) {
        NSLog(@"%@",object);
        [_textView setText:[NSString stringWithFormat:@"%@",object]];
    }];
}
@end
