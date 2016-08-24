//
//  CategoryModel.m
//  SHAilu
//
//  Created by 尹成 on 16/8/17.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "CategoryModel.h"

@interface CategoryModel(){
    
}

@end

@implementation CategoryModel

+ (NSString *)getParentCategoryById:(NSInteger)parentCategoryId{
    
    NSArray *titles = @[@"阀口袋",
                        @"方底袋",
                        @"热封口袋",
                        @"缝底袋",
                        @"塑料阀口袋",
                        @"FFS膜"];
    
    return [titles yc_objectAtIndex:parentCategoryId];
}

+ (NSArray *)getChildCategoryById:(NSInteger)parentCategoryId{

    NSArray *arry = @[@[@{@"title":@"外阀式",@"pic":@"category_1_1"},@{@"title":@"内阀式",@"pic":@"category_1_2"}],
                      @[@{@"title":@"方底袋",@"pic":@"category_2_1"}],
                      @[@{@"title":@"M折边热封口袋",@"pic":@"category_3_1"},@{@"title":@"方底热封口袋",@"pic":@"category_3_2"}],
                      @[@{@"title":@"缝底袋",@"pic":@"category_4_1"},@{@"title":@"M折边缝底袋",@"pic":@"category_4_2"}],
                      @[@{@"title":@"外阀式",@"pic":@"category_5_1"},@{@"title":@"内阀式",@"pic":@"category_5_2"}],
                      @[@{@"title":@"单层重包装膜",@"pic":@"category_6_1"},@{@"title":@"双层铝塑重包装膜",@"pic":@"category_6_2"}],
                      @[]];
    
    return [arry yc_objectAtIndex:parentCategoryId];
}

+ (NSDictionary *)getSpecs{
    
    NSDictionary *dict = @{@"a":@[@"进口白色牛皮纸",@"进口本色牛皮纸",@"国产本色牛皮纸",@"进口白色伸性纸",@"进口本色伸性纸",@"国产本色伸性纸",@"进口白色高透伸性纸",@"进口本色高透伸性纸",@"淋膜",@"纸铝复合材料"],
                           @"b":@[@"LDPE",@"HDPE",@"7层共挤高阻隔膜",@"铝塑复合膜"],
                           @"weight":@[@70,@75,@80,@90,@100,@125]};

    return dict;
}

@end
