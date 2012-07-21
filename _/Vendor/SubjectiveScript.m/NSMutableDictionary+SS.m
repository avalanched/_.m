//
//  NSMutableDictionary+SS.m
//  SubjectiveScript.m
//
//  Created by Kevin Malakoff on 7/17/12.
//  Copyright (c) 2012 Kevin Malakoff. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "NSMutableDictionary+SS.h"

@implementation NSMutableDictionary (Object)

+ (O*(^)(UI capacity))newWithCapacity
{
  return ^(UI capacity) {
    return [O dictionaryWithCapacity:capacity];
  };
}

+ (O*(^)(const KV* values))newAKV
{
  return ^(const KV* values) {
    O* result = O.new;
    for (const id* value = (const id*) values; *value != nil; value+=2) {
      [result setValue:value[1] forKey:value[0]];
    }
    return result;
  };
}

- (O*(^)(id key, id value))set
{
  return ^(id key, id value) {
    [self setValue:value forKey:key];
    return self;
  };
}

- (O*(^)(const KV* values))setAKV
{
  return ^(const KV* values) {
    for (const id* value = (const id*) values; *value != nil; value+=2) {
      [self setValue:value[1] forKey:value[0]];
    }
    return self;
  };
}

- (O*(^)(id key))delete_
{
  return ^(id key) {
    [self removeObjectForKey:key];
    return self;
  };
}

@end
