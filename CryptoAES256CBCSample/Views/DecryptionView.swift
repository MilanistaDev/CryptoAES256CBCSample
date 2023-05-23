//
//  DecryptionView.swift
//  CryptoAES256CBCSample
//
//  Created by Takuya Aso on 2023/05/17.
//

import SwiftUI
import IDZSwiftCommonCrypto

struct DecryptionView: View {
    private let encryptedString = "{Input target encrypted String}"
    private let keyPhrase = "{Input key phrase String}"
    private let iv = "{Input iv(Hex String)}"

    @State private var isPresented = false
    @State private var result = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("Target encrypted String")
                .font(.body)
                .bold()
                .padding(.bottom, 8.0)

            Text(encryptedString)
                .font(.body)
                .padding(.bottom, 32.0)

            Text("KeyPhrase")
                .font(.body)
                .bold()
                .padding(.bottom, 8.0)
            Text(keyPhrase)
                .font(.body)
                .padding(.bottom, 32.0)

            Text("iv")
                .font(.body)
                .bold()
                .padding(.bottom, 8.0)
            Text(iv)
                .font(.body)
                .padding(.bottom, 32.0)

            Spacer()

            Button {
                decryptAES256CBC()
            } label: {
                Text("Decription")
                    .padding(.all)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .background(Color.pink)
            .cornerRadius(8.0)
        }
        .padding(.all, 20.0)
        .navigationTitle("Decryption Sample")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $isPresented) {
            Alert(
                title: Text("Result"),
                message: Text(result)
            )
        }
    }
}

extension DecryptionView {
    private func decryptAES256CBC() {
        let iv = arrayFrom(hexString: iv)
        let keyStr = keyPhrase.utf8ToHexString()
        let keyHex = arrayFrom(hexString: keyStr)

        let cryptor = Cryptor(operation: .decrypt, algorithm: .aes, mode: .CBC, padding: .PKCS7Padding, key: keyHex, iv: iv)

        let cipherData = Data(base64Encoded: encryptedString)
        let decryptedText = cryptor.update(data: cipherData!)?.final()
        let decryptedData = dataFrom(byteArray: decryptedText!)
        result = String(data: decryptedData, encoding: .utf8) ?? "Decryption failed."
        isPresented = true
    }
}

extension String {
  func utf8ToHexString() -> String {
      return self.utf8.map { NSString(format: "%2X", $0) as String }.reduce("", {$0 + $1})
  }
}

struct DecryptionView_Previews: PreviewProvider {
    static var previews: some View {
        DecryptionView()
    }
}
