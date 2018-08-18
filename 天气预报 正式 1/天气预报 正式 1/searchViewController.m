//
//  searchViewController.m
//  天气预报 正式 1
//
//  Created by 萨缪 on 2018/8/13.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "searchViewController.h"
#import "ViewController.h"
@interface searchViewController ()

@end

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"6.jpg"]];
    
    _textField = [[ UITextField alloc] init];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.94f alpha:1.00f];
    _textField.frame = CGRectMake(5, 20, [UIScreen mainScreen].bounds.size.width-10, 30);
    [_textField addTarget:self action:@selector(selectCityTextField:) forControlEvents:UIControlEventEditingDidEnd];
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"54,.png"]];
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    _textField.leftView = imageView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    
    //实现实时监听功能！！！
    //[_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //注册通知
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValue) name:@"changeValue" object:nil];
    //实现实时监听功能！！！
    
    
    
    
    [self.view addSubview:_textField];
    
}



- (void)selectCityTextField:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(giveCityName:)]) {
        [_delegate giveCityName:textField.text];
    }
    
    //NSLog(@"-----");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//导航栏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(pressBackBtn:)];
    self.navigationController.navigationItem.rightBarButtonItem = item;
    self.navigationItem.title = @"添加城市";
    //self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    //self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    
}

//- (void)pressBackBtn:(UIButton *)btn
//{
//    [_delegate giveCityName:_textField.text];
//
//    [self.navigationController popViewControllerAnimated:YES];
//}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
