//
//  LQJokeTableViewController.m
//  Spice
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 spice. All rights reserved.
//

#import "LQJokeTableViewController.h"
#import "LQtJokeTableViewCell.h"
#import "LQModel.h"
#import "AppDelegate.h"
@interface LQJokeTableViewController ()
{
    BOOL isHave;
}
@property(nonatomic,strong)NSMutableDictionary *dic;
@property(nonatomic,strong)NSMutableArray *sarry;
@property(nonatomic,strong)UIImageView *bigimage;

@end

@implementation LQJokeTableViewController

-(NSMutableArray *)sarry{
    if (_sarry == nil) {
        _sarry = [NSMutableArray array];
    }
    return _sarry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSMutableArray *array1 =[NSMutableArray array];
//    self.sarry =[[NSMutableArray array]copy];
    self.tableView.rowHeight = 400;
    self.dic =[[NSMutableDictionary dictionary]mutableCopy];
    [self AFHTTP];
    isHave = YES;
    

}
-(void)AFHTTP{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];//设置相应内容类型
    [manager GET:@"http://duanzi.duowan.com/index.php?r=duanzi/topicList&page=1&pageSize=30&sort=2" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dic2 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSArray *arry = [[dic2 objectForKey:@"result"]objectForKey:@"list"];
        for (NSDictionary *dic in arry) {
            LQModel *modellist =[[LQModel alloc]init];
            [modellist setValuesForKeysWithDictionary:dic];
            [self.sarry addObject:modellist];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"%d",self.sarry.count);
    return self.sarry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LQtJokeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"LQtJokeTableViewCell" owner:nil options:nil]lastObject];
    }
    
    LQModel *model = self.sarry[indexPath.row];
    cell.userName.text = model.nickname;
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    cell.MainLabel.text = model.content;
    [cell.MainImage sd_setImageWithURL:[NSURL URLWithString:[[model.imagelist objectAtIndex:0] objectForKey:@"large"]]];
//    [self.bigimage sd_setImageWithURL:[NSURL URLWithString:[[model.imagelist objectAtIndex:0] objectForKey:@"large"]]];
    cell.MainImage.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimage:)];
    [cell.MainImage addGestureRecognizer:tap];
    return cell;
}
-(void)clickimage:(UITapGestureRecognizer*)tap{
//    UIView *MainView =tap.view;
    NSLog(@"111");
//    MainView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIView *mainview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tap.view.frame = CGRectMake(40, 60, self.view.frame.size.width-80, self.view.frame.size.height-120);
    mainview.backgroundColor =[UIColor blackColor];
    mainview.alpha = 0.8;
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    [window addSubview:mainview];
    [window addSubview:tap.view];
//
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
