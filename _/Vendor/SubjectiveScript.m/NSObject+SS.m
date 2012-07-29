//
//  NSObject+SS.m
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

#import "NSObject+SS.h"
#import "SS+Types.h"
#import "SS+Number.h"
#import "SSArguments.h"
#import "NSString+SS.h"
#import "NSArray+SS.h"
#import "NSNumber+SS.h"

const NSS* SSTypeObject = @"object";

@implementation NSObject (SS)

- (const NSS*)typeof {return SSTypeObject; }
- (NSS*(^)())toString
{
  return ^{
    if (SS.isNull(self)) return @"";
    return self.description;
  };
}
- (NSS*)className { return NSStringFromClass([self class]); }
- (NSS*)mutableClassName { return nil; }
- (B(^)(NSS* className))instanceof {
  return ^(NSS* className) {
    return [self isKindOfClass:NSClassFromString(className)];
  };
}

// use dynamic type checking for some JavaScript operations to reduce manual casting
- (NSO*(^)(id key))get
{
  return ^NSO*(id key) {
    I index;
  
    // requesting a property
    if ([key isKindOfClass:[NSString class]])
    {
      NSS* stringKey = (NSS*)key;
      if ([(NSS*)key isEqual:@"length"])
        return N.I(self.length);

      // support JavaScript-style indexing by string
      N* indexNumber = SS.parseInt(stringKey);

#ifdef DEBUG
      NSAssert(indexNumber, @"get did not recognize key '%@'", stringKey);
#endif
      index = indexNumber ? indexNumber.I : 0;
    }
    else
      index = ((N*)key).I;
    return self.getAt(index);
  };
}
- (NSO*(^)(I index))getAt
{
  return ^NSO*(I index) {
#ifdef DEBUG
    NSAssert(nil, @"getAt not implemented for this type");
#endif

    return nil;
  };
}

- (NSO*(^)(id key, NSO* value))set
{
  return ^NSO*(id key, NSO* value) {
#ifdef DEBUG
    NSAssert(nil, @"set not implemented for this type");
#endif

    return nil;
  };
}

- (B(^)(id key))hasOwnProperty
{
  return ^B(id key) {
    return false;
  };
}

- (UI)length
{
  // base class can be triggered by KeyValueCoding
  if (SS.isArray(self)) return ((NSA*)self).count;
  if (SS.isString(self)) return ((NSS*)self).length;
  return 0;
}
- (S*(^)(NSS* separator))join
{
#ifdef DEBUG
  NSAssert(nil, @"join not implemented for this type");
#endif

  return nil;
}

- (B(^)(NSO* obj))in
{
  return ^B(NSO* obj) {
    return obj.get(self) != nil;
  };
}

- (A*(^)(id value))push
{
  return ^(NSO* obj) {
    #ifdef DEBUG
      NSAssert(nil, @"push not implemented for this type");
    #endif
    return A.new;
  };
}

// helper
- (NSComparisonResult)compare:(NSO*)other
{
  if (SS.isString(self)) return [(NSS*)self compare:(NSS*)other];
  if (SS.isNumber(self)) return [(N*)self compare:(N*)other];
  if (SS.isDate(self)) return   [(Date*)self compare:(Date*)other];

#ifdef DEBUG
  NSAssert(nil, @"cannot compare the provided objects");
#endif 

  return NSOrderedSame;
}

@end
