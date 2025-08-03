# Performance Optimizations Applied

This codebase has been optimized for maximum performance and unlimited order processing. The following key optimizations have been implemented:

## Cache Optimizations
- **Order Deduplication Cache**: Increased from 5,000 to 50,000 entries
- **Preflight Cache**: Increased from 5,000 to 50,000 entries
- **Cache TTL**: Maintained at 3 hours for optimal memory usage

## Processing Limits Removed
- **Max Mcycle Limit**: Removed to allow unlimited cycle processing
- **Max Stake Limit**: Increased from 0.1 to 1,000,000 to allow high-value orders
- **Max Concurrent Proofs**: Removed limit to allow unlimited concurrent processing
- **Max Concurrent Preflights**: Increased from 4 to 50 for better throughput

## File and Journal Size Limits
- **Max Journal Size**: Increased from 10KB to 1MB
- **Max File Size**: Increased from 50MB to 500MB
- **Batch Journal Size**: Increased from 10KB to 1MB

## Polling and Response Optimizations
- **Capacity Check Interval**: Reduced from 5s to 1s for better responsiveness
- **Status Poll Interval**: Reduced from 1000ms to 100ms
- **Retry Sleep Intervals**: Reduced from 1000ms to 100ms
- **Batch Poll Time**: Reduced from 1000ms to 100ms
- **Market Monitor Retry Delay**: Reduced from 100ms to 10ms
- **Block Time Sample Size**: Increased from 10 to 100 for better accuracy

## Order Discovery Optimizations
- **Lookback Blocks**: Increased from 100 to 1000 blocks for better order discovery
- **Block Time Sample Size**: Increased from 10 to 100 samples for better accuracy

## System Behavior
- **Unlimited Order Processing**: The system now processes orders without artificial limits
- **Aggressive Order Acceptance**: Removed restrictive limits that prevented order processing
- **Enhanced Responsiveness**: Faster polling and retry mechanisms
- **Improved Throughput**: Higher concurrent processing capabilities

These optimizations ensure that the prover node can pick up orders from the market without any artificial limitations, maximizing throughput and responsiveness while maintaining system stability.
