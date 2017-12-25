//
//  CBaseHashmap.m
//  QQLeak
//
//  Tencent is pleased to support the open source community by making OOMDetector available.
//  Copyright (C) 2017 THL A29 Limited, a Tencent company. All rights reserved.
//  Licensed under the MIT License (the "License"); you may not use this file except
//  in compliance with the License. You may obtain a copy of the License at
//
//  http://opensource.org/licenses/MIT
//
//  Unless required by applicable law or agreed to in writing, software distributed under the
//  License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
//  either express or implied. See the License for the specific language governing permissions
//  and limitations under the License.
//
//

#include "CBaseHashmap.h"

#if __has_feature(objc_arc)
#error  this file should use MRC
#endif

extern malloc_zone_t *memory_zone;

CBaseHashmap::CBaseHashmap(size_t entrys,monitor_mode monitormode)
{
    entry_num = entrys;
    hashmap_entry = (base_entry_t *)hashmap_malloc((entry_num)*sizeof(base_entry_t));
    for(size_t i = 0; i < entry_num;i++){
        base_entry_t *entry_tmp = hashmap_entry + i;
        entry_tmp->root = NULL;
    }
    record_num = 0;
    access_num = 0;
    collision_num = 0;
    mode = monitormode;
}

CBaseHashmap::~CBaseHashmap(){
    hashmap_free(hashmap_entry);
}

void *CBaseHashmap::hashmap_malloc(size_t size){
    return memory_zone->malloc(memory_zone,size);
}

void CBaseHashmap::hashmap_free(void *ptr){
    memory_zone->free(memory_zone,ptr);
}

monitor_mode CBaseHashmap::getMode()
{
    return mode;
}

base_entry_t *CBaseHashmap::getHashmapEntry()
{
    return hashmap_entry;
}

size_t CBaseHashmap::getEntryNum()
{
    return entry_num;
}

size_t CBaseHashmap::getRecordNum()
{
    return record_num;
}
size_t CBaseHashmap::getAccessNum()
{
    return access_num;
}
size_t CBaseHashmap::getCollisionNum()
{
    return collision_num;
}
