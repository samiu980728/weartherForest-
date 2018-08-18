//
//  FirstCellWeatherViewController.m
//  天气预报 正式 1
//
//  Created by 萨缪 on 2018/8/14.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "FirstCellWeatherViewController.h"
#import "ViewController.h"
//屏幕宽

#define kScreenW [UIScreen mainScreen].bounds.size.width

//屏幕高

#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface FirstCellWeatherViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
//@property(nonatomic) UITableView *livesListTable;
//
//@property(nonatomic) UIButton *bottomButton;


@end

@implementation FirstCellWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"3.jpg"]];
    //在这个界面的 viewDidLoad中 写scrollorView 然后写5个自定义View。在那其中分别写当滚动视图滚动到哪个界面时，在这个界面上应该出现的东西
    
    pushTempArray = [[NSMutableArray alloc] init];
    pushTimearray = [[NSMutableArray alloc] init];
    pushNameArray = [[NSMutableArray alloc] init];
    
    
    CGRect clientRect = [UIScreen mainScreen].bounds;
    
    _livesListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, clientRect.size.width, clientRect.size.height) style:UITableViewStylePlain];
    
    [self.view addSubview:_livesListTable];
    
    _livesListTable.delegate = self;
    
    _livesListTable.dataSource = self;
    
    _livesListTable.backgroundColor = [UIColor clearColor];
    
    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.bottomButton.frame = CGRectMake(kScreenW - 80, kScreenH - 140, 60, 60);
    
    [self.bottomButton setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    
    [self.bottomButton addTarget:self action:@selector(onTapLiveBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.bottomButton];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"ViewController 中的 _pushFirstNameStr = %@",_pushFirstNameStr);
    if ( [_pushFirstNameStr isEqualToString:@"beijing"] ){
        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"https://free-api.heweather.com/s6/weather/lifestyle?location=beijing&key=70c5ee7d3a214fefaee2fc9ca8eeb52f"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            NSInteger flag = 0;
            for (NSInteger i = 0; i < [pushNameArray count]; i++ ) {
                if ( [dict[@"HeWeather6"][0][@"basic"][@"parent_city"] isEqualToString:[NSString stringWithFormat:@"%@",[pushNameArray objectAtIndex:i]]] ){
                    flag = 1;
                    break;
                }
            }
            
            if ( flag == 0 ){
                [pushNameArray addObject:dict[@"HeWeather6"][0][@"basic"][@"parent_city"]];
                
                [pushTimearray addObject:dict[@"HeWeather6"][0][@"update"][@"loc"]];
                
                [pushTempArray addObject:dict[@"HeWeather6"][0][@"lifestyle"][0][@"brf"]];
                
                NSLog(@"进去了----");
            }
            //NSLog(@"dict = %@",dict);
            
            NSLog(@"pushTimearray = %@",pushTimearray);
            
            NSLog(@"pushTempArray = %@",pushTempArray);
            
            
        }] resume];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell1 = nil;
    UITableViewCell * cell2 = nil;
    UITableViewCell * cell3 = nil;
    UITableViewCell * cell4 = nil;
    UITableViewCell * cell5 = nil;
    
    if ( indexPath.row == 0 ){
        cell1 = [_livesListTable dequeueReusableCellWithIdentifier:@"cell1"];
        if ( cell1 == nil ){
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        UILabel * label1 = [[UILabel alloc] init];
        //label1.frame = CGRectMake(40, 30, <#CGFloat width#>, <#CGFloat height#>)
    }
    if ( indexPath.row > 0 ){
        cell2 = [_livesListTable dequeueReusableCellWithIdentifier:@"cell2"];
        if ( cell2 == nil ){
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        cell2.backgroundColor = [UIColor clearColor];
    }
    return cell2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row == 0 ){
    return 200;
    }
    else if ( indexPath.row == 1 ){
        return 70;
    }
    else if ( indexPath.row == 2 ){
        return 190;
    }
    return 60;
}

- (void)onTapLiveBtn

{
    
    //[self dismissViewControllerAnimated:YES completion:nil];
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
