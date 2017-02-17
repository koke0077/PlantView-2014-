//
//  SingleObject.h
//  PlantView
//
//  Created by kimsung jun on 2014. 6. 1..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleObject : NSObject{
    
    NSMutableArray *currentArray;
}

+(SingleObject *)getSingleObject;

//-(BOOL)saveArray;

@property (nonatomic, strong)NSMutableArray *currentArray;

@end
