import Foundation
import Capacitor
import MediaPlayer
import AVFoundation

@objc(VolumeControlPlugin)
public class VolumeControlPlugin: CAPPlugin {
    private var volumeView: MPVolumeView?
    
    override public func load() {
        volumeView = MPVolumeView(frame: CGRect.zero)
        volumeView?.alpha = 0.01
        if let volumeView = volumeView {
            bridge?.viewController?.view.addSubview(volumeView)
        }
    }
    
    @objc func getCurrentVolume(_ call: CAPPluginCall) {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
            let volume = audioSession.outputVolume
            let normalizedVolume = Int(volume * 100)
            call.resolve(["volume": normalizedVolume])
        } catch {
            call.reject("Failed to get volume: \(error.localizedDescription)")
        }
    }
    
    @objc func setVolume(_ call: CAPPluginCall) {
        guard let volume = call.getFloat("volume") else {
            call.reject("Must provide a volume value")
            return
        }
        
        let normalizedVolume = volume / 100.0
        if normalizedVolume < 0 || normalizedVolume > 1 {
            call.reject("Volume must be between 0 and 100")
            return
        }
        
        let showUI = call.getBool("showUI") ?? false
        
        DispatchQueue.main.async { [weak self] in
            if showUI {
                self?.showVolumeUI()
            }
            
            if let slider = self?.volumeView?.subviews.first(where: { $0 is UISlider }) as? UISlider {
                slider.value = Float(normalizedVolume)
                call.resolve()
            } else {
                call.reject("Unable to find volume slider")
            }
        }
    }
    
    private func showVolumeUI() {
        volumeView?.alpha = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.volumeView?.alpha = 0.01
        }
    }
}