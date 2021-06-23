# git commit 签名

##

1. 安装gnupg

```shell 
brew install gnupg
```

2. 附加配置 (bash/zsh)

```shell 
export GPG_TTY=$(tty)
```

3. 生成密钥对

```shell
gpg --full-generate-key

```

4. 配置git使用密钥签名

```shell
git config --global user.signingkey <keyid>
git config --global commit.gpgsign true
```

5. commit with key

```shell
git commit -S<keyid> -m""
```

6. 倒出公钥

```shell
gpg --export -a <keyid>
```


