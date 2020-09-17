// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// This is was built using the JC reverb implentation found in FAUST.
/// According to the source code, the specifications for this implementation were
/// found on an old SAIL DART backup tape.
/// 
/// This class is derived from the CLM JCRev function, which is based on the use of
/// networks of simple allpass and comb delay filters.  This class implements three series
/// allpass units, followed by four parallel comb filters, and two decorrelation delay lines in
/// parallel at the output.
/// 
public class ChowningReverb: Node, AudioUnitContainer, Toggleable {

    public static let ComponentDescription = AudioComponentDescription(effect: "jcrv")

    public typealias AudioUnitType = InternalAU

    public private(set) var internalAU: AudioUnitType?

    // MARK: - Parameters

    // MARK: - Audio Unit

    public class InternalAU: AudioUnitBase {

        public override func createDSP() -> DSPRef {
            akCreateDSP("ChowningReverbDSP")
        }
    }

    // MARK: - Initialization

    /// Initialize this reverb node
    ///
    /// - Parameters:
    ///   - input: Input node to process
    ///
    public init(
        _ input: Node
        ) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioUnit = avAudioUnit
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else {
                fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit

        }
        connections.append(input)
    }
}
