//
//  EncryptionView.swift
//  CryptoAES256CBCSample
//
//  Created by Takuya Aso on 2023/05/17.
//

import SwiftUI
import IDZSwiftCommonCrypto

struct EncryptionView: View {
    private let targetString = "{Input target String}"
    private let keyPhrase = "{Input key phrase String}"
    private let iv = "{Input iv(Hex String)}"

    @State private var isPresented = false
    @State private var result = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("Target String")
                .font(.body)
                .bold()
                .padding(.bottom, 8.0)

            Text(targetString)
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
                encryptAES256CBC()
            } label: {
                Text("Encription")
                    .padding(.all)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .background(Color.indigo)
            .cornerRadius(8.0)
        }
        .padding(.all, 20.0)
        .navigationTitle("Encryption Sample")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $isPresented) {
            Alert(
                title: Text("Result"),
                message: Text(result)
            )
        }
    }
}

extension EncryptionView {
    private func encryptAES256CBC() {
        let iv = arrayFrom(hexString: iv)
        let keyStr = keyPhrase.utf8ToHexString()
        let keyHex = arrayFrom(hexString: keyStr)

        let cryptor = Cryptor(operation: .encrypt, algorithm: .aes, mode: .CBC, padding: .PKCS7Padding, key: keyHex, iv: iv)

        let cipherData = cryptor.update(string: targetString)?.final()
        let encryptedString = dataFrom(byteArray: cipherData!).base64EncodedString()
        result = encryptedString
        isPresented = true
    }
}

struct EncryptionView_Previews: PreviewProvider {
    static var previews: some View {
        EncryptionView()
    }
}
