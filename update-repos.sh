#!/bin/bash

# SSQ Docs - Repository Update Script
# 모든 클론된 레포지토리를 최신 상태로 업데이트합니다.

echo "🔄 Updating all repositories..."

# ppfront (talenx branch)
if [ -d "ppfront" ]; then
    echo "📦 Updating ppfront (talenx)..."
    cd ppfront && git fetch origin && git reset --hard origin/talenx && cd ..
else
    echo "📦 Cloning ppfront (talenx)..."
    git clone -b talenx https://github.com/hcgtheplus/ppfront.git
fi

# ppback (talenx-dev branch)
if [ -d "ppback" ]; then
    echo "📦 Updating ppback (talenx-dev)..."
    cd ppback && git fetch origin && git reset --hard origin/talenx-dev && cd ..
else
    echo "📦 Cloning ppback (talenx-dev)..."
    git clone -b talenx-dev https://github.com/hcgtheplus/ppback.git
fi

# talenx-admin (dev branch)
if [ -d "talenx-admin" ]; then
    echo "📦 Updating talenx-admin (dev)..."
    cd talenx-admin && git fetch origin && git reset --hard origin/dev && cd ..
else
    echo "📦 Cloning talenx-admin (dev)..."
    git clone -b dev https://github.com/hcgtheplus/talenx-admin.git
fi

# theplus-back (talenx-dev branch)
if [ -d "theplus-back" ]; then
    echo "📦 Updating theplus-back (talenx-dev)..."
    cd theplus-back && git fetch origin && git reset --hard origin/talenx-dev && cd ..
else
    echo "📦 Cloning theplus-back (talenx-dev)..."
    git clone -b talenx-dev https://github.com/hcgtheplus/theplus-back.git
fi

# perpl-download (talenx branch)
if [ -d "perpl-download" ]; then
    echo "📦 Updating perpl-download (talenx)..."
    cd perpl-download && git fetch origin && git reset --hard origin/talenx && cd ..
else
    echo "📦 Cloning perpl-download (talenx)..."
    git clone -b talenx https://github.com/hcgtheplus/perpl-download.git
fi

# perpl-notification (dev branch)
if [ -d "perpl-notification" ]; then
    echo "📦 Updating perpl-notification (dev)..."
    cd perpl-notification && git fetch origin && git reset --hard origin/dev && cd ..
else
    echo "📦 Cloning perpl-notification (dev)..."
    git clone -b dev https://github.com/hcgtheplus/perpl-notification.git
fi

echo "✅ All repositories updated successfully!"
