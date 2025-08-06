# Maintainer: Your Name <your.email@example.com>
pkgname=strength-tracker
pkgver=1.0.0
pkgrel=1
pkgdesc="A comprehensive terminal-based workout tracking application for Mark Rippetoe's Starting Strength program"
arch=('any')
url="https://github.com/yourusername/strength-tracker"
license=('MIT')
depends=('python' 'python-click' 'python-rich' 'python-pyyaml')
makedepends=('python-setuptools' 'python-wheel' 'python-build')
source=("$pkgname-$pkgver.tar.gz::https://github.com/yourusername/strength-tracker/archive/v$pkgver.tar.gz")
sha256sums=('SKIP')

build() {
  cd "$srcdir/$pkgname-$pkgver"
  python -m build --wheel --no-isolation
}

package() {
  cd "$srcdir/$pkgname-$pkgver"
  python -m installer --destdir="$pkgdir" dist/*.whl
  
  # Install license
  install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
  
  # Install documentation
  install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
  install -Dm644 CHANGELOG.md "$pkgdir/usr/share/doc/$pkgname/CHANGELOG.md"
}
