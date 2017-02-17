//
//  SingleObject.m
//  PlantView
//
//  Created by kimsung jun on 2014. 6. 1..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "SingleObject.h"

@implementation SingleObject
@synthesize currentArray;

+(SingleObject *)getSingleObject{
    
    static SingleObject *shareInstance = nil;
    
    if (shareInstance == nil) {
        
        @synchronized(self){
            if (shareInstance == nil) {
                
                
                
                shareInstance = [[SingleObject alloc]init];
            }
        }
    }
    
    return shareInstance;
}

//-(BOOL)saveArray{
//    
//    return YES;
//    
//}

@end
