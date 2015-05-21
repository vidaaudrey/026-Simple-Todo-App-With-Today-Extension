//
//  WKFrameworkConfig.swift
//  Apple Watch App
//
//  Created by Audrey Li on 5/10/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import Foundation

public struct WKConfig {
    public static let NSUserDefaultSuiteName = "group.com.shomigo.AppleWatchBathCode"
    
    
    // App Specific 
    public static let TodoListAppUserDefaultKeyName = "todoItems"
    public static let OMDBAPIURLPrefix = "http://www.omdbapi.com/?s="
    public static let OMDBAPIKey = "97f4ef30 "
    //example: http://img.omdbapi.com/?i=tt2294629&apikey=97f4ef30
    public static let TheMoviesDBURL = "http://private-anon-c1d8533ce-themoviedb.apiary-mock.com/3/configuration"
    
    //Google Place must enable both iOS and Server Key 
    public static let GooglePlaceAPIURLPrefix = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="
  // https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&types=food&name=cruise&key=
    public static let GooglePlaceIOSAPIKey = "AIzaSyDsWN2Q2JoVNa8iXWmuaQhxaCXeq0GUxrs"
    public static let GooglePlaceServerAPIKey = "AIzaSyDxJvKhHoWiaW1egwjaS-IJL9tyaSqgxlg"
    public static let GooglePlacePhotoURLPrefix = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference="
    public static let GooglePlaceGetPlaceByIDURLPrefix = "https://maps.googleapis.com/maps/api/place/details/json?placeid="

    
 // detail place link: https://maps.googleapis.com/maps/api/place/details/json?placeid=ChIJGZ2lxTauEmsRJ1C7wmla-3I&key=AIzaSyDxJvKhHoWiaW1egwjaS-IJL9tyaSqgxlg
// search result link: https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&types=&name=&key=AIzaSyDxJvKhHoWiaW1egwjaS-IJL9tyaSqgxlg 

}
