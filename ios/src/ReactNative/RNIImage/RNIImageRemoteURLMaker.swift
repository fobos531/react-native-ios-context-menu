//
//  RNIImageRemoteURLMaker.swift
//  react-native-ios-context-menu
//
//  Created by Dominic Go on 9/27/22.
//

import Foundation


internal class RNIImageRemoteURLMaker {
  
  lazy var imageLoader: RCTImageLoaderWithAttributionProtocol? = {
    RNIUtilities.sharedBridge?.module(forName: "ImageLoader") as?
      RCTImageLoaderWithAttributionProtocol;
  }();
  
  let url: URL;
  let imageLoadingConfig: RNIImageLoadingConfig;
  
  var image: UIImage?;
  
  /// Reminder: Use weak self to prevent retain cycle + memory leak
  var onImageDidLoadBlock: ((_ sender: RNIImageRemoteURLMaker) -> Void)?;
  
  var synthesizedURLRequest: URLRequest? {
    URLRequest(url: self.url);
  };
  
  init?(
    dict: NSDictionary,
    imageLoadingConfig: NSDictionary?,
    onImageDidLoadBlock: ((_ sender: RNIImageRemoteURLMaker) -> Void)? = nil
  ){
    guard let urlString = dict["url"] as? String,
          let url = URL(string: urlString)
    else { return nil };
    
    self.url = url;
    self.imageLoadingConfig =
      RNIImageLoadingConfig(dict: imageLoadingConfig ?? [:]);
    
    self.onImageDidLoadBlock = onImageDidLoadBlock;
    
    if self.imageLoadingConfig.shouldLazyLoad {
      self.loadImage();
    };
  };
  
  func loadImage(){
    guard let urlRequest = self.synthesizedURLRequest,
          let imageLoader = self.imageLoader
    else { return };
    
    imageLoader.loadImage(with: urlRequest){ [weak self] error, image in
      guard let strongSelf = self else { return };
      
      print("DEBUG - image: \(image.debugDescription)");
      
      strongSelf.image = image;
      strongSelf.onImageDidLoadBlock?(strongSelf);
    };
  };
};
