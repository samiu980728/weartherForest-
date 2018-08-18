//
//  MainViewController.h
//  天气预报 正式 1
//
//  Created by 萨缪 on 2018/8/14.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

{
    NSMutableArray * pushTimearray;
    
    NSMutableArray * pushNameArray;
    
    NSMutableArray * pushTempArray;
}


@property (nonatomic, copy) NSString * pushFirstNameStr;

@property (nonatomic, strong) UIButton * backButton;

@property (nonatomic, strong) NSMutableArray * cNameArray;

@property(nonatomic) UIButton *bottomButton;

@property (nonatomic, assign) NSInteger indexRowInt;



@end
