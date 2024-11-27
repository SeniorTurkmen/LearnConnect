//
//  PreviewCourseViewController.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import Managers
import Utilities
import DataProvider
import UIComponents
import AVFoundation

public final class PreviewCourseViewController: BaseViewController<PreviewCourseViewModel> {
    private lazy var videoView: VideoPlayerView = {
        let view = VideoPlayerView()
        view.delegate = self
        return view
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        subscribeViewModel()
        viewModel.viewDidLoad()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        videoView.stop(isReset: false)
    }
    
    public override var screenName: String? {
        return ScreenNameConstants.previewCourse
    }
}

// MARK: - UILayout
extension PreviewCourseViewController {
    
    final func addSubViews() {
        addVideoView()
    }
    
    final func addVideoView() {
        view.addSubview(videoView)
        videoView.edgesToSuperview()
    }
}

// MARK: - ConfigureContents
extension PreviewCourseViewController {
    
    final func configureContents() {
        configureViewController()
        configureVideoView()
    }
    
    final func configureViewController() {
        navigationItem.title = "Video"
    }
    
    final func configureVideoView() {
        guard let url = viewModel.content?.videURL else { return }
        let item = CoreDataManager.get(UserWatchHistory.self, key: viewModel.content?.id)
        let sec = item?.seconds
        videoView.prepareVideoURL(
            url,
            vc: self
        )
        videoView.play(isMuted: false, seconds: sec)
    }
}

// MARK: SubscribeViewModel
extension PreviewCourseViewController {
    
    final func subscribeViewModel() {

    }
}

// MARK: SubscrVideoPlayerViewDelegateibeViewModel
extension PreviewCourseViewController: VideoPlayerViewDelegate {
    public func playStatus(_ isPlay: Bool, currentTime: CMTime?) {
        guard !isPlay, let currentTime else { return }
        let item = CoreDataManager.get(UserWatchHistory.self, key: viewModel.content?.id)
        if let item {
            item.seconds = currentTime.seconds
            CoreDataManager.update(item)
        } else {
            if let entity = CoreDataManager.create(UserWatchHistory.self) {
                entity.id = Int64(viewModel.content?.id ?? -1)
                entity.seconds = currentTime.seconds
                CoreDataManager.update(entity)
            }
        }
    }
}
