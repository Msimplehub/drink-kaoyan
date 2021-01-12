package com.meta.framework.common.core.redis;

import java.util.*;
import java.util.concurrent.TimeUnit;

import com.meta.framework.common.config.MetaConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.*;
import org.springframework.stereotype.Component;

/**
 * spring redis 工具类
 *
 * @author ruoyi
 **/
@SuppressWarnings(value = {"unchecked", "rawtypes"})
@Component
@Slf4j
public class RedisCache {
	@Autowired
	public RedisTemplate redisTemplate;

	@Autowired
	private MetaConfig metaConfig;

	private String encodeKey(String key){
		return String.format("%s:%s", metaConfig.getName(), key);
	}

	private String decodeKey(String key){
		return key.replace(String.format("%s:",metaConfig.getName()), "");
	}

	/**
	 * 缓存基本的对象，Integer、String、实体类等
	 *
	 * @param key   缓存的键值
	 * @param value 缓存的值
	 */
	public <T> void setCacheObject(final String key, final T value) {
		redisTemplate.opsForValue().set(encodeKey(key), value);
	}

	/**
	 * 缓存基本的对象，Integer、String、实体类等
	 *
	 * @param key      缓存的键值
	 * @param value    缓存的值
	 * @param timeout  时间
	 * @param timeUnit 时间颗粒度
	 */
	public <T> void setCacheObject(final String key, final T value, final Integer timeout, final TimeUnit timeUnit) {
		redisTemplate.opsForValue().set(encodeKey(key), value, timeout, timeUnit);
	}

	/**
	 * 设置有效时间
	 *
	 * @param key     Redis键
	 * @param timeout 超时时间
	 * @return true=设置成功；false=设置失败
	 */
	public boolean expire(final String key, final long timeout) {
		return expire(encodeKey(key), timeout, TimeUnit.SECONDS);
	}

	/**
	 * 设置有效时间
	 *
	 * @param key     Redis键
	 * @param timeout 超时时间
	 * @param unit    时间单位
	 * @return true=设置成功；false=设置失败
	 */
	public boolean expire(final String key, final long timeout, final TimeUnit unit) {
		return redisTemplate.expire(encodeKey(key), timeout, unit);
	}

	/**
	 * 获得缓存的基本对象。
	 *
	 * @param key 缓存键值
	 * @return 缓存键值对应的数据
	 */
	public <T> T getCacheObject(final String key) {
		ValueOperations<String, T> operation = redisTemplate.opsForValue();
		return operation.get(encodeKey(key));
	}

	/**
	 * 删除单个对象
	 *
	 * @param key
	 */
	public boolean deleteObject(final String key) {
		return redisTemplate.delete(encodeKey(key));
	}

	/**
	 * 删除集合对象
	 *
	 * @param collection 多个对象
	 * @return
	 */
	public long deleteObject(final Collection collection) {
		return redisTemplate.delete(collection);
	}

	/**
	 * 缓存List数据
	 *
	 * @param key      缓存的键值
	 * @param dataList 待缓存的List数据
	 * @return 缓存的对象
	 */
	public <T> long setCacheList(final String key, final List<T> dataList) {
		Long count = redisTemplate.opsForList().rightPushAll(encodeKey(key), dataList);
		return count == null ? 0 : count;
	}

	/**
	 * 获得缓存的list对象
	 *
	 * @param key 缓存的键值
	 * @return 缓存键值对应的数据
	 */
	public <T> List<T> getCacheList(final String key) {
		return redisTemplate.opsForList().range(encodeKey(key), 0, -1);
	}

	/**
	 * 缓存Set
	 *
	 * @param key     缓存键值
	 * @param dataSet 缓存的数据
	 * @return 缓存数据的对象
	 */
	public <T> long setCacheSet(final String key, final Set<T> dataSet) {
		Long count = redisTemplate.opsForSet().add(encodeKey(key), dataSet);
		return count == null ? 0 : count;
	}

	/**
	 * 获得缓存的set
	 *
	 * @param key
	 * @return
	 */
	public <T> Set<T> getCacheSet(final String key) {
		return redisTemplate.opsForSet().members(encodeKey(key));
	}

	/**
	 * 缓存Map
	 *
	 * @param key
	 * @param dataMap
	 */
	public <T> void setCacheMap(final String key, final Map<String, T> dataMap) {
		if (dataMap != null) {
			redisTemplate.opsForHash().putAll(encodeKey(key), dataMap);
		}
	}

	/**
	 * 获得缓存的Map
	 *
	 * @param key
	 * @return
	 */
	public <T> Map<String, T> getCacheMap(final String key) {
		return redisTemplate.opsForHash().entries(encodeKey(key));
	}

	/**
	 * 往Hash中存入数据
	 *
	 * @param key   Redis键
	 * @param hKey  Hash键
	 * @param value 值
	 */
	public <T> void setCacheMapValue(final String key, final String hKey, final T value) {
		redisTemplate.opsForHash().put(encodeKey(key), hKey, value);
	}

	/**
	 * 获取Hash中的数据
	 *
	 * @param key  Redis键
	 * @param hKey Hash键
	 * @return Hash中的对象
	 */
	public <T> T getCacheMapValue(final String key, final String hKey) {
		HashOperations<String, String, T> opsForHash = redisTemplate.opsForHash();
		return opsForHash.get(encodeKey(key), hKey);
	}

	/**
	 * 获取多个Hash中的数据
	 *
	 * @param key   Redis键
	 * @param hKeys Hash键集合
	 * @return Hash对象集合
	 */
	public <T> List<T> getMultiCacheMapValue(final String key, final Collection<Object> hKeys) {
		return redisTemplate.opsForHash().multiGet(encodeKey(key), hKeys);
	}

	/**
	 * 获得缓存的基本对象列表
	 *
	 * @param pattern 字符串前缀
	 * @return 对象列表
	 */
/*	public Collection<String> keys(final String pattern) {
		return redisTemplate.keys(pattern);
	}*/

	/**
	 * 获得缓存的基本对象列表
	 *
	 * @param pattern 字符串前缀
	 * @return 对象列表
	 */
	public Collection<String> scan(final String pattern) {

		return (Collection<String>) redisTemplate.execute((RedisCallback<Collection<String>>) connection -> {
			Collection<String> keysTmp = new HashSet<>(); try (Cursor<byte[]> cursor = connection.scan(new ScanOptions.ScanOptionsBuilder()
					.match(encodeKey(pattern))
					.count(10000).build())) { while (cursor.hasNext()) {
				String key = new String(cursor.next(), "Utf-8");
				keysTmp.add(decodeKey(key));
			}
			} catch (Exception e) {
				log.error(e.getMessage(), e); throw new RuntimeException(e);
			} return keysTmp;
		});
		
	}
}