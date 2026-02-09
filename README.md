# fcitx5-vmk-nix

Nix package for VMK (Vietnamese Micro Key) - Bộ gõ tiếng Việt không underline cho Fcitx5.

## Giới thiệu

VMK là bộ gõ tiếng Việt dành cho Fcitx5, được phát triển với mục tiêu mang lại trải nghiệm gõ **non-preedit** (không có gạch chân) hoàn hảo trên Linux, mô phỏng chính xác cơ chế hoạt động của UniKey trên Windows.

Upstream: https://github.com/thanhpy2009/VMK

## Các chế độ gõ

Package này đã được customize để chỉ giữ lại 2 mode:

- **VMK2** (Modern Surrounding) - Mode mặc định
  - Sử dụng API `Surrounding Text` 
  - Tốc độ gõ cực nhanh và mượt mà
  - Tương thích ~50% (có thể lỗi trong terminal)

- **VMK-Pre** (Standard Preedit)
- Sử dụng preedit truyền thống của Fcitx5
  - Tương thích 100%
  - Không có underline

## Sử dụng

### Thêm vào flake.nix

```nix
{
  inputs.fcitx5-vmk-nix = {
    url = "github:<your-username>/fcitx5-vmk-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, fcitx5-vmk-nix, ... }: {
    # ...
  };
}
```

### Trong NixOS configuration

```nix
{ pkgs, fcitx5-vmk-nix, ... }: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-vmk-nix.packages.${pkgs.system}.fcitx5-vmk
    ];
  };
}
```

## Build

```bash
nix build
```

## License

GPL-3.0 (theo upstream VMK)
