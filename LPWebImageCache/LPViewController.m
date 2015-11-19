//
//  LPViewController.m
//  LPWebImageCache
//
//  Created by QFWangLP on 15/11/18.
//  Copyright © 2015年 QFWang. All rights reserved.
//

#import "LPViewController.h"
#import "AppableViewCell.h"
#import "LPApp.h"

@interface LPViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation LPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AppableViewCell class]) bundle:nil] forCellReuseIdentifier:[AppableViewCell cellIdentifire]];
    
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [LPApp arrayApp].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AppableViewCell cellIdentifire]];
    LPApp *model = [LPApp arrayApp][indexPath.row];
    cell.model = model;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AppableViewCell cellDefaultHeight];
}
@end
