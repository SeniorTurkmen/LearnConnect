//
//  VideoPlayerView.swift
//  UIComponents
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import AVFoundation
import AVKit

public protocol VideoPlayerViewDelegate: AnyObject {
    func playStatus(_ isPlay: Bool, currentTime: CMTime?)
}

public class VideoPlayerView: UIView {
    
    public weak var delegate: VideoPlayerViewDelegate?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var queuePlayer: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var looper: AVPlayerLooper?
    private var playerItem: AVPlayerItem?
    public var asset: AVAsset?
    private var playerItemContext = 0
    private var videoURL: URL?
    private var playerItemObserver: NSKeyValueObservation?
    private var playerViewController: AVPlayerViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidFinishPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = CGRect(
            x: 0,
            y: 0,
            width: self.containerView.frame.size.width,
            height: self.containerView.frame.size.height
        )
    }
    
    deinit {
        queuePlayer?.removeObserver(self, forKeyPath: "timeControlStatus", context: &playerItemContext)
        NotificationCenter.default.removeObserver(self)
    }

    public func prepareVideoURL(_ url: String, vc: UIViewController) {
        guard let videoURL = URL(string: url) else { return }
        let asset = AVAsset(url: videoURL)
        self.asset = asset
        self.playerItem = AVPlayerItem(asset: asset)
        self.queuePlayer = AVPlayer(url: videoURL)

        guard let queuePlayer = queuePlayer else { return }
        self.playerViewController?.player?.pause()
        self.playerViewController?.player = nil
        self.playerViewController = nil
        self.playerViewController = AVPlayerViewController()
        playerViewController?.player = queuePlayer
        playerViewController?.showsPlaybackControls = true
        playerViewController?.showsTimecodes = true
        playerViewController?.videoGravity = .resizeAspectFill

        queuePlayer.addObserver(
            self,
            forKeyPath: "timeControlStatus",
            options: [.old, .new],
            context: &playerItemContext
        )

        //  queuePlayer.addObserver(self, forKeyPath: #keyPath(AVPlayer.rate), context: &playerItemContext)
        if let view = playerViewController {
            containerView.addSubview(view.view)
            vc.addChild(view)
            view.view.edgesToSuperview()
        }
    }
    
    public func play(isMuted: Bool, seconds: Double?) {
        isMutedVideo(isMuted: isMuted)
        if let seconds {
            self.queuePlayer?.seek(to: CMTime.init(seconds: seconds, preferredTimescale: 1))
        }
        self.queuePlayer?.play()
    }

    public func pause() {
        self.queuePlayer?.pause()
    }

    public func stop(isReset: Bool = true) {
        self.queuePlayer?.pause()
        guard isReset else { return }
        self.queuePlayer?.seek(to: CMTime.init(seconds: 0, preferredTimescale: 1))
    }
    
    public func reset() {
        self.queuePlayer?.seek(to: CMTime.init(seconds: 0, preferredTimescale: 1))
    }

    public func repeatPlay(isMuted: Bool) {
        isMutedVideo(isMuted: isMuted)
        self.queuePlayer?.seek(to: CMTime.init(seconds: 0, preferredTimescale: 1))
        self.queuePlayer?.play()
    }

    private func isMutedVideo(isMuted: Bool) {
        self.queuePlayer?.isMuted = isMuted
    }

    public func unload() {
        self.playerLayer?.removeFromSuperlayer()
        self.playerLayer = nil
        self.queuePlayer = nil
    }

    public func stopLoop() {
        looper?.disableLooping()
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &playerItemContext else {
            super.observeValue(
                forKeyPath: keyPath,
                of: object,
                change: change,
                context: context
            )
            return
        }

        if keyPath == "timeControlStatus",
           let change = change,
           let newValue = change[NSKeyValueChangeKey.newKey] as? Int,
           let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
            let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            if newStatus != oldStatus {
                DispatchQueue.main.async {
                    let currenTime = self.queuePlayer?.currentTime()
                    if newStatus == .playing {
                        self.delegate?.playStatus(true, currentTime: currenTime)
                    } else {
                        self.delegate?.playStatus(false, currentTime: currenTime)
                    }
                }
            }
        }
    }
    
    @objc private func videoDidFinishPlaying(_ notification: Notification) {
        repeatPlay(isMuted: true)
    }
}

// MARK: - UILayout
extension VideoPlayerView {
    
    private func addSubViews() {
        addContainerView()
    }
    
    private func addContainerView() {
        addSubview(containerView)
        containerView.edgesToSuperview()
    }
}
