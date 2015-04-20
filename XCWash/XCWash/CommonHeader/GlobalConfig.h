//
//  GlobalConfig.h
//  BJXH-patient
//
//  Created by wu weili on 14-7-7.
//  Copyright (c) 2014年 archermind. All rights reserved.
//

#ifndef BJXH_patient_GlobalConfig_h
#define BJXH_patient_GlobalConfig_h


// ******************************  此段不需设置 ********************************** //
#pragma mark --  Base parameters
typedef enum ProjectMode
{
    DEBUG_MODE = 0x1,// 调试模式，平时调试使用
    NO_NETWORK_MODE = 0x10,  // 不联网模式，即UI_DEBUG模式(UI调试模式)
    RELEASE_MODE = 0x100,  // 发布模式，
    SILENT_MODE = RELEASE_MODE,// 安静模式.不输出LOG的模式，但此模式并不控制文件log，即使是安静模式，文件LOG仍能输出。影响控制台LOG，启用后控制台log输出停止。
    
    SLIENT_NO_NETWORK_MODE = 0x1000// 不联网，无命令行log模式，仅一期测试版本使用此模式
}IM_PROJECT_MODE;


// ******************************  以下为各种控制开关 ********************************** //
#pragma mark --  Developer Settings



/******************************
 * 默认工程模式，由开发者调试时候设置
 *******************************/
#ifndef PROJECT_MODE
#define  PROJECT_MODE 0x100//设置此处
#elif
#warning "PROJECT_MODE already defined in other files."
#endif

/**
 *	调试模式：调试LOG开启，服务器连接开启。 通用开发调试模式，发布时候应该用发布模式
 */

#ifdef PROJECT_MODE
#if PROJECT_MODE == 0x1
#define CONSOLE_LOG_ON
#define NET_CONNECTION_ON
#define DEBUG_MODE
#endif
#endif

/**
 *	无网络模式：调试LOG开启，服务器连接关闭。 只调试UI，或者做界面演示时候使用的模式。
 */
#ifdef PROJECT_MODE
#if PROJECT_MODE == 0x10
#define CONSOLE_LOG_ON
#define NET_CONNECTION_OFF
#define NO_NETWORK_MODE
#endif
#endif


/**
 *	发布、静默模式：调试LOG关闭，服务器连接开启。 最终版本发布时候使用此模式
 */
#ifdef PROJECT_MODE
#if PROJECT_MODE == 0x100
#define CONSOLE_LOG_ON   //发布版本的时候关闭consolelog 不过现在暂时打开 CONSOLE_LOG_OFF  CONSOLE_LOG_ON
#define NET_CONNECTION_ON
#define FILE_LOG_ON  //打印日志到本地
#define SILENT_MODE
#define RELEASE_MODE
#endif
#endif


/**
 *	静默无网络模式：调试LOG关闭，服务器连接关闭。第一阶段版本发布时候使用此模式。
 */
#ifdef PROJECT_MODE
#if PROJECT_MODE == 0x1000
#define CONSOLE_LOG_OFF
#define NET_CONNECTION_OFF
#define SLIENT_NO_NETWORK_MODE
#endif
#endif

#endif
