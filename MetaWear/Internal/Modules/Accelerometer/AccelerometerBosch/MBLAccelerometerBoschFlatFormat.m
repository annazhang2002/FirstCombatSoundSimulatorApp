/**
 * MBLAccelerometerBoschFlatFormat.m
 * MetaWear
 *
 * Created by Stephen Schiffli on 8/11/15.
 * Copyright 2014-2015 MbientLab Inc. All rights reserved.
 *
 * IMPORTANT: Your use of this Software is limited to those specific rights
 * granted under the terms of a software license agreement between the user who
 * downloaded the software, his/her employer (which must be your employer) and
 * MbientLab Inc, (the "License").  You may not use this Software unless you
 * agree to abide by the terms of the License which can be found at
 * www.mbientlab.com/terms.  The License limits your use, and you acknowledge,
 * that the Software may be modified, copied, and distributed when used in
 * conjunction with an MbientLab Inc, product.  Other than for the foregoing
 * purpose, you may not use, reproduce, copy, prepare derivative works of,
 * modify, distribute, perform, display or sell this Software and/or its
 * documentation for any purpose.
 *
 * YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
 * PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE,
 * NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
 * MBIENTLAB OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT, NEGLIGENCE,
 * STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER LEGAL EQUITABLE
 * THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES INCLUDING BUT NOT LIMITED
 * TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE OR CONSEQUENTIAL DAMAGES, LOST
 * PROFITS OR LOST DATA, COST OF PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY,
 * SERVICES, OR ANY CLAIMS BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY
 * DEFENSE THEREOF), OR OTHER SIMILAR COSTS.
 *
 * Should you have any questions regarding your right to use this Software,
 * contact MbientLab via email: hello@mbientlab.com
 */

#import "MBLAccelerometerBoschFlatFormat.h"
#import "MBLAccelerometerBoschFlatData+Private.h"
#import "MBLModule+Private.h"
#import "MBLModuleInfo.h"

@implementation MBLAccelerometerBoschFlatFormat

- (instancetype)initWithAccelerometer:(MBLAccelerometerBosch *)accelerometer
{
    self = [super initEncodedDataWithLength:1];
    if (self) {
        self.accelerometer = accelerometer;
    }
    return self;
}

- (id)entryFromData:(NSData *)data date:(NSDate *)date
{
    const uint8_t raw = *(uint8_t *)data.bytes;
    BOOL faceDown = NO;
    BOOL isFlat = NO;
    if (self.accelerometer.moduleInfo.moduleRevision >= 2) {
        faceDown = raw & (1 << 1);
        isFlat = raw & (1 << 2);
        return [[MBLAccelerometerBoschFlatData alloc] initWithIsFlat:isFlat faceDown:faceDown timestamp:date];
    } else {
        isFlat = raw & (1 << 1);
        return [[MBLAccelerometerBoschFlatData alloc] initWithIsFlat:isFlat timestamp:date];
    }
}

- (NSNumber *)numberFromDouble:(double)value
{
    // TODO How to also check for up vs down
    if (value) {
        return [NSNumber numberWithInt:3];
    } else {
        return [NSNumber numberWithInt:1];
    }
}

@end
