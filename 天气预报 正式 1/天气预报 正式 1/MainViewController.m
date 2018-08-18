//
//  MainViewController.m
//  天气预报 正式 1
//
//  Created by 萨缪 on 2018/8/14.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "MainViewController.h"
#import "JPXFirstUIView.h"
#import "JPXSecondUIView.h"
#import "JPXThreeUIView.h"

@interface MainViewController ()
//屏幕宽

#define kScreenW [UIScreen mainScreen].bounds.size.width

//屏幕高

#define kScreenH [UIScreen mainScreen].bounds.size.height
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化
    //_cNameArray = [[NSMutableArray alloc] init];
    
    
    //创建滚动界面
    UIScrollView * mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    //是否整页滚动
    mainScrollView.pagingEnabled = YES;
    //是否可以开启滚动效果
    mainScrollView.scrollEnabled = YES;
    
    //设置画布大小
    //刚好能滑动6个
    mainScrollView.contentSize = CGSizeMake(kScreenW*_cNameArray.count, kScreenH);
    mainScrollView.bounces = NO;
    
    //横向 纵向弹动效果
    // mainScrollView.alwaysBounceVertical = YES;
    // mainScrollView.alwaysBounceHorizontal = YES;
    //显示水平滚动条
    mainScrollView.showsHorizontalScrollIndicator = YES;
    
    mainScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"3.jpg"]];
    
    
    //得先把它加上 再加下面的那个
    [self.view addSubview:mainScrollView];
    
    
    //添加UIView
    //先把城市数据传递到这里 再通过属性传值传到各个滚动界面
    
    
    //JPXFirstUIView * firstUIView = [[JPXFirstUIView alloc] init];
    //怎么判断 是否建立几个滚动视图呢？ 对 _pushFirstNameStr 这个得用数组来装
    //然后遍历数组来找到 
    
    //遍历cNameArray数组 分别将数组的各个单元赋值给 不同UIView的cityString
    
    //还没加for循环遍历数组之前 每找到数组中一个单位的元素 就创建一个UIView
    
    NSLog(@"[_cNameArray count] ++++++ = %li",[_cNameArray count]);
    
    //通过协议传值 把indexPath.row传过来 然后 if （ i == 0 ) 重新为该城市赋值该单元格的内容
    //再把indexPath.row 那个单元格的元素替换为数组第一个单元的元素  完了之后再替换回来。
    
    //[_cNameArray objectAtIndex:0] = [_cNameArray objectAtIndex:_indexRowInt];
    NSString * namStr = [[NSString alloc] init];
    NSString * changStr = [[NSString alloc] init];
    
    
    //该修改那个滚动视图第一次出现应出现所选单元格的BUG了 试试 NSMutableArray 的另一种创建方法 能不能不用在这个文件初始化数组就可以直接赋值？？？
    //mainController.cNameArray = [NSMutableArray arrayWith...这种方法]; ..... . .... .... .. .
    
    
    //在这里进行替换元素
    //替换元素之前还得把 在_indexRowInt 位置上的元素取出来
    NSString * middleValueStr = [_cNameArray objectAtIndex:0];
    NSString * hontValueStr = [_cNameArray objectAtIndex:_indexRowInt];
    NSLog(@"hontValueStr = %@",hontValueStr);
    NSInteger jInt = 0;
    NSLog(@"_cNameArray.count = %li",_cNameArray.count);
    if ( [_cNameArray isKindOfClass:[NSArray class]] && _cNameArray.count > _indexRowInt && _cNameArray.count != 1 && _cNameArray.count > 0 ){
        NSLog(@"_indexRowInt ==== %li",_indexRowInt);
        NSLog(@"111111111");
    [_cNameArray replaceObjectAtIndex:jInt withObject:hontValueStr];
        NSLog(@"222222222");
    [_cNameArray replaceObjectAtIndex:_indexRowInt withObject:middleValueStr];
        NSLog(@"33333333");
    NSLog(@"替换后的数组：====%@",_cNameArray);
    }
    
    
    for (NSInteger i = 0;  i < [_cNameArray count]; i++) {
        NSLog(@"i = %li",i);
            JPXFirstUIView * firstUIView = [[JPXFirstUIView alloc] initWithFrame:CGRectMake(kScreenW*i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) andcityString:[NSString stringWithFormat:@"%@",_cNameArray[i]]];
            [mainScrollView addSubview:firstUIView];
    }
    
    if ( [_cNameArray isKindOfClass:[NSArray class]] && _cNameArray.count > _indexRowInt && _cNameArray.count != 1 ){
    [_cNameArray replaceObjectAtIndex:_indexRowInt withObject:[_cNameArray objectAtIndex:0]];
    [_cNameArray replaceObjectAtIndex:0 withObject:middleValueStr];
    
    NSLog(@"返回替换前的数组 _cNameArray = %@ ",_cNameArray);
    }
    
    //加需求
    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.bottomButton.frame = CGRectMake(kScreenW - 35, kScreenH - 35, 30, 30);
    
    [self.bottomButton setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    
    [self.bottomButton addTarget:self action:@selector(onTapLiveBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.bottomButton];
}

- (void)onTapLiveBtn
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
