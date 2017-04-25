//
//  ZCIngredientsViewController.m
//  掌厨
//
//  Created by Libo on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCIngredientsViewController.h"
#import "ZCMacro.h"
#import "ZCIngredientsDataModel.h"
#import "ZCIngredientsCell.h"

@interface ZCIngredientsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionArray;
@end

@implementation ZCIngredientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ZCIngredientsCell class] forCellReuseIdentifier:NSStringFromClass([ZCIngredientsCell class])];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"MaterialSubtype";
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    [self requestData:params];
}

- (void)requestData:(NSMutableDictionary *)params {
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        
        self.sectionArray = [ZCIngredientsDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCIngredientsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCIngredientsCell class]) forIndexPath:indexPath];
    cell.model = self.sectionArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCIngredientsDataModel *dataModel = self.sectionArray[indexPath.section];
    return dataModel.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0f;
    }
    return 10;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ZCBackgroundColor;
        _tableView.sectionHeaderHeight = 0.0f;
        _tableView.sectionFooterHeight = 0.0f;
        // 如果tableView是grouped样式，且没有自定义tableHeaderView，那么tableView的顶部会多出一段头部高度，这段高度无法修改。只能通过创建一张自定义的view，给个很小很小的高度，然后赋值给tableHeaderView即可。注意：这张自定义的view的高度不能直接给0，给0的话仍然是默认系统头部高度，要给一个无限接近于0的高度
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableHeaderView = view;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
