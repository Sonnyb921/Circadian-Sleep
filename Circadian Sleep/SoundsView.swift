//
//  SoundsView.swift
//  Circadian Sleep
//
//  Created by Joshua A. Brown on 11/9/23.
//
import AVFoundation
import SwiftUI

struct SoundsView: View {
    let sounds = [("Ocean", "ocean"), ("Forest", "forest"), ("Traffic", "Traffic"), ("White Noise", "White_Noise")]
    @State var audioPlayer: AVAudioPlayer?

    func playSound(soundName: String) {
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }

    var body: some View {
        NavigationView {
            ZStack{
                Color.clear.withSharedBackground()
                    .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Sleep Sounds")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10.0)
                ForEach(sounds, id: \.0) { sound in
                    Button(action: {
                        playSound(soundName: sound.1)
                    }) {
                        HStack {
                            Text(sound.0)
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 60.0)
                                
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(.white)
                                .padding(.horizontal, 15.0)
                                .font(.system(size: 30))
                        }
                    }
                }
            }
            
            
            
                }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    NavigationLink(destination: HomeView()) {
                        NavigationButton(iconName: "house", label: "Home")
                            .foregroundColor(.white)
                            .padding(.trailing, 25)
                    }

                    NavigationLink(destination: SettingsView()) {
                        NavigationButton(iconName: "gearshape", label: "Settings")
                            .foregroundColor(.white)
                            .padding(25)
                    }

                    NavigationLink(destination: ChartsView()) {
                        NavigationButton(iconName: "chart.bar.xaxis", label: "Charts")
                            .foregroundColor(.white)
                            .padding(.leading, 25)
                    }
                    .navigationBarBackButtonHidden(true)
                }
                .padding()
            }
        }
        }
    }
}

struct Previews_SoundsView_Previews: PreviewProvider {
    static var previews: some View {
        SoundsView()
    }
}
