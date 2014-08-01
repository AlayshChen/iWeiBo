//
//  colorPrint.m
//  iWeiBo
//
//  Created by Alaysh on 7/17/14.
//  Copyright (c) 2014 Alaysh. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_RESET   "\x1b[0m"

void printStr(NSString *str, NSNumber *type) {
    switch (type.intValue%6) {
        case 0:
            printf(ANSI_COLOR_RED     "%s"     ANSI_COLOR_RESET "",[str UTF8String]);
            break;
        case 1:
            printf(ANSI_COLOR_GREEN     "%s"     ANSI_COLOR_RESET "",[str UTF8String]);
            break;
        case 2:
            printf(ANSI_COLOR_YELLOW     "%s"     ANSI_COLOR_RESET "",[str UTF8String]);
            break;
        case 3:
            printf(ANSI_COLOR_BLUE     "%s"     ANSI_COLOR_RESET "",[str UTF8String]);
            break;
        case 4:
            printf(ANSI_COLOR_MAGENTA     "%s"     ANSI_COLOR_RESET "",[str UTF8String]);
            break;
        case 5:
            printf(ANSI_COLOR_CYAN     "%s"     ANSI_COLOR_RESET "",[str UTF8String]);
            break;
        default:
            break;
    }
}
void printRedStr(NSString *str) {
    printf(ANSI_COLOR_RED     "%s"     ANSI_COLOR_RESET "",[str UTF8String]);
}

void printGreenStr(NSString *str) {
    
    printf(ANSI_COLOR_GREEN     "%s"     ANSI_COLOR_RESET "",[str UTF8String]);
}

void printYellowStr(NSString *str) {
    
    printf(ANSI_COLOR_YELLOW     "%s"     ANSI_COLOR_RESET "",[str UTF8String]);
}

void printBlueStr(NSString *str) {
    
    printf(ANSI_COLOR_BLUE     "%s"     ANSI_COLOR_RESET "",[str UTF8String]);
}

void printMagentaStr(NSString *str) {
    
    printf(ANSI_COLOR_MAGENTA     "%s"     ANSI_COLOR_RESET "",[str UTF8String]);
}

void printCyanStr(NSString *str) {
    
    printf(ANSI_COLOR_CYAN     "%s"     ANSI_COLOR_RESET "",[str UTF8String]);
}
